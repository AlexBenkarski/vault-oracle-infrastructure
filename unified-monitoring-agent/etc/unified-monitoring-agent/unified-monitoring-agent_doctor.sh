#!/bin/bash

VERSION=1.12

if [[ $LOGNAME != "root" ]]; then
    echo "This script must be run as root user"
    echo "Usage:"
    echo "  # sudo su"
    echo "  # bash griffin_doctor.sh"
    exit 2
fi

echo "==== Running Griffin doctor v${VERSION} ===="
echo "This script will collect information and identify most common errors"
echo "Follow provided resolution when applicable"
echo ""

# Variables
GRIFFIN_LOG_PATH="/var/log/griffin/griffin.log"
GRIFFIN_CONFIG_DOWNLOADER_PATH="/var/log/griffin/griffin_config_downloader.log"
GRIFFIN_LOGS=()
GRIFFIN_TEMP_LOG_PATH="/tmp/griffin.log"
GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH="/tmp/griffin_config_downloader.log"
GRIFFIN_DOCTOR_TEMP_LOG_PATH="/tmp/griffin_doctor.log"
REGION=""
HOSTCLASS="NO_HOSTCLASS"
CODE_LINE_NUMBER=200
ERROR_NUM=0
CHEF_MANAGED="false"
CHEF_LAST_RUN="failed"
CHEF_FIRSTBOOT_COMPLETE="false"
OSTREE_BOOTED_FILE="/run/ostree-booted"
EVERGREEN_RELEASE_FILE="/etc/evergreen-release.json"
TEE=("$(which tee)" -a)

if [[ ! ${TEE[0]} =~ "tee" ]]; then
    echo "ERROR: this script needs tee from coreutils"
    exit 1
fi

# Set default, these files may not be present on non Chef managed hosts
if [[ -f "/etc/region" ]]; then
    REGION=$(cat /etc/region)
fi
if [[ -f "/etc/hostclass" ]]; then
    HOSTCLASS=$(cat /etc/hostclass)
fi

############################################################
#                       Functions                          #
############################################################

function print_test() {
    printf "* Checking %-80s ..... " "$@"
}

function save_griffin_logs() {
    printf "\n** Griffin log files **\n" >>$GRIFFIN_DOCTOR_TEMP_LOG_PATH
    ls -l /var/log/griffin >>$GRIFFIN_DOCTOR_TEMP_LOG_PATH

    printf "\n** AuditD log files **\n" >>$GRIFFIN_DOCTOR_TEMP_LOG_PATH
    ls -l /var/log/audit >>$GRIFFIN_DOCTOR_TEMP_LOG_PATH

    # Capture lines from griffin.log.0 and griffin.log.1 in case griffin.log has just been rotated
    if [ -f "${GRIFFIN_LOG_PATH}.0" ]; then
        GRIFFIN_LOGS+=("${GRIFFIN_LOG_PATH}.0")
    fi
    if [ -f "${GRIFFIN_LOG_PATH}.1" ]; then
        GRIFFIN_LOGS+=("${GRIFFIN_LOG_PATH}.1")
    fi
    if [ -f "$GRIFFIN_LOG_PATH" ]; then
        GRIFFIN_LOGS+=("${GRIFFIN_LOG_PATH}")
    else
        echo "WARNING: $GRIFFIN_LOG_PATH file doesn't exist"
    fi
    # Get the latest 200 lines of the combined griffin.log.0 and griffin.log and store in a temporary file
    if ! cat "${GRIFFIN_LOGS[@]}" >"$GRIFFIN_TEMP_LOG_PATH.source"; then
        echo "ERROR: failed to get lines from ${GRIFFIN_LOGS[*]}"
        exit 1
    fi
    if ! tail -n $CODE_LINE_NUMBER -q "$GRIFFIN_TEMP_LOG_PATH.source" >$GRIFFIN_TEMP_LOG_PATH 2>/dev/null; then
        echo "ERROR: failed to get lastest $CODE_LINE_NUMBER lines griffin log"
        exit 1
    fi
}

############################################################
#               Restart all services for test              #
############################################################
if [[ $1 == "test" ]]; then
    echo "** Restarting services"
    sudo systemctl -q restart griffin_config_downloader
    echo "waiting for griffin_config_downloader.service to restart"
    sleep 20
    sudo systemctl status griffin_config_downloader

    sudo systemctl -q restart griffin
    echo "waiting for griffin.service to restart"
    sleep 20
    sudo systemctl status griffin
fi

############################################################
#                Collect information                       #
############################################################
echo -e "==== Collecting system information ====\n"
date >$GRIFFIN_DOCTOR_TEMP_LOG_PATH

# If the host is a evergreen host or standard OL9 host
if [ -e "$OSTREE_BOOTED_FILE" ] || [ -e "$EVERGREEN_RELEASE_FILE" ]; then
    echo -e "Evergreen host\n"
    date >$GRIFFIN_DOCTOR_TEMP_LOG_PATH

    printf "** OS Version **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    uname -a | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

    printf "\n** Local filesystems **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    mount -l -t ext4 | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

    printf "\n** Installed Images **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    podman ps | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    achilles agent ls | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

    echo -e "==== All agents deployed by achilles ====\n"
    achilles agent ls | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

    echo -e "========== Griffin Specific Info ==========\n"

    echo -e "==== Container Status ====\n"
    podman ps | grep siem | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

    echo -e "==== Systemctl service status and logs of managing griffin container and pod Status ====\n"
    systemctl status achilles-sec-griffin | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    journalctl -u achilles-sec-griffin | tail -200f >>$GRIFFIN_DOCTOR_TEMP_LOG_PATH

    save_griffin_logs

    if ! tail -n $CODE_LINE_NUMBER -q "$GRIFFIN_CONFIG_DOWNLOADER_PATH" >$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH; then
        echo "ERROR: failed to get log of griffin_config_downloader "
        exit 1
    fi

    echo -e "==== Flight Recorder status ====\n"
    FR_CMD_OUTPUT=$(/var/opt/flightrecorder/bin/oci-flight-recorder modules griffin 2>&1)
    echo "$FR_CMD_OUTPUT" >>$GRIFFIN_DOCTOR_TEMP_LOG_PATH
    FR_STATUS=$(echo "$FR_CMD_OUTPUT" | grep 'status:' | awk '{print $2}')
    FR_DAEMON=$(echo "$FR_CMD_OUTPUT" | grep 'daemon:' | awk '{print $2}')
    echo -e "==== Supervisorctl status of griffin and griffin downloader ====\n"
    podman exec "$(podman ps | grep siem | cut -f 1 -d " ")" /usr/local/bin/supervisorctl -c /srv/siem-dist/etc/supervisor/supervisord.conf status | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

    FAULT=0 #variable to know if there is fault in the griffin and customer should be reporting it to Unified agent team
    if ! podman ps | grep siem; then
        echo "No SIEM containers are running."
        echo "Run sudo systemctl restart achilles-sec-griffin"
        FAULT=1
    else
        container_health_status=$(podman ps | grep siem | awk '{print $9}' | sed 's/[()]//g')
        echo "SIEM containers are running."
        if [ "$container_health_status" = "healthy" ]; then
            echo "The SIEM container is healthy."
        else
            echo "The SIEM container is unhealthy"
            FAULT=1
        fi
    fi

    if [ "$FR_STATUS" = "PASS" ]; then
        echo "FR status is passing"
    else
        echo "FR status is failing"
        FAULT=1
    fi
    if [ "$FR_DAEMON" = 'PASS' ]; then
        echo "FR daemon is passing"
    else
        echo "FR daemon is failing"
        FAULT=1
    fi

    if [ "$FAULT" = "1" ]; then
        echo "Restart griffin service"
        echo sudo systemctl restart griffin
        echo "Restart griffin using"
        echo sudo podman exec "$(podman ps | grep siem | cut -f 1 -d " ")" /usr/local/bin/supervisorctl -c /srv/siem-dist/etc/supervisor/supervisord.conf restart griffin
        echo "Restarting griffin config downloader to download config, we dont have config downloader timer in Evergreen griffin"
        echo sudo podman exec "$(podman ps | grep siem | cut -f 1 -d " ")" /usr/local/bin/supervisorctl -c /srv/siem-dist/etc/supervisor/supervisord.conf restart config_download_one_time
        echo "Raise query in #oci_unified_agent_users or create a UAOPS ticket with files $GRIFFIN_DOCTOR_TEMP_LOG_PATH , $GRIFFIN_TEMP_LOG_PATH , $GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH  "
    fi

    ############################################
    # Not doing further tests for Evergreen host
    ############################################
    exit 0
fi

# Non Evergreen host
printf "** OS Version **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
uname -a | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

if rpm --quiet -q chef-es3-run; then
    CHEF_MANAGED="true"
    printf "** Chef versions **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    if [[ -f /etc/.firstboot_complete ]]; then
        CHEF_FIRSTBOOT_COMPLETE="true"
        cat /etc/motd | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    else
        printf "ERROR: Chef firstboot did not completed\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    fi
    if [[ -f /etc/chef/.chef-last-run-status ]] && [[ $(cat /etc/chef/.chef-last-run-status) == "success" ]]; then
        CHEF_LAST_RUN="success"
    else
        printf "ERROR: Chef last run was not successful\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    fi
else
    printf "** Hostclass **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
    echo "$HOSTCLASS" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
fi

printf "\n** Local filesystems state **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
mount -l -t ext4 | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

printf "\n** Local filesystems disk space usage **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
df -hl | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

printf "\n** Installed packaged **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
printf "\n* Telemetry \n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
rpm -qa 'telemetry-*' | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
printf "\n* PKI \n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
rpm -qa 'secprod-pki-*' | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
printf "\n* FlightRecorder \n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
rpm -qa oci-flightrecorder | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
rpm -qa wlp-agent | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

printf "\n** Griffin Downloader service **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
systemctl status griffin_config_downloader.service | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

printf "\n** Griffin Downloader timer **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
systemctl list-timers griffin_config_downloader.timer | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

printf "\n** Griffin service **\n" | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH
systemctl status griffin.service | "${TEE[@]}" $GRIFFIN_DOCTOR_TEMP_LOG_PATH

#capture griffin logs
save_griffin_logs

# Get downloader journal
if ! journalctl -u griffin_config_downloader --no-pager --since "2 hour ago" >$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH; then
    echo "ERROR: failed to get log of griffin_config_downloader "
    exit 1
fi

# Display some information about OS and package version on the console
if [[ $CHEF_MANAGED == "true" ]]; then
    printf "\n** INSTANCE IS CHEF MANAGED **\n"
    # Ensure Chef firstboot completed
    if [[ $CHEF_FIRSTBOOT_COMPLETE == "true" ]]; then
        cat /etc/motd
    else
        printf "\n** ERROR: Chef firstboot did not completed **\n"
        echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
        echo "Error: Chef is installed but Chef firstboot did not completed"
        echo "--------------------------------------- Solution -----------------------------------------------"
        echo "Solution: follow Chef runook https://devops.oci.oraclecorp.com/runbooks/CHEF/chef-how-tos/chef-diagnosing-chef-failures/chef-how-to-use-chef-doctor"
        echo -e "---------------------------------------- End ---------------------------------------------------\n"
    fi
    # Ensure chef last run completed
    if [[ $CHEF_LAST_RUN != "success" ]]; then
        printf "\n** ERROR: Chef last run was not successful **\n"
        echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
        echo "Error: Chef last run was not successful"
        echo "--------------------------------------- Solution -----------------------------------------------"
        echo "Solution: follow Chef runook https://devops.oci.oraclecorp.com/runbooks/CHEF/chef-how-tos/chef-diagnosing-chef-failures/chef-how-to-use-chef-doctor"
        echo -e "---------------------------------------- End ---------------------------------------------------\n"
    fi
else
    printf "\n** INSTANCE IS _NOT_ CHEF MANAGED **\n"
    printf "\n** OS Version **\n"
    if [[ -f /etc/oracle-release ]]; then
        cat /etc/oracle-release
    else
        uname -a
    fi
fi

############################################################
#          Errors which can be fixed by end user           #
############################################################
echo -e "\n==== Validating service health and log output ====\n"

# incorrect pki package
# on chefless host we need to mock the region
if [[ $REGION == "" ]]; then
    REGION="*"
fi
# convert specific region name
REGION=${REGION/us-phoenix-1/r2}
REGION=${REGION/us-seattle-1/r1}
PKG="secprod-pki-root-ca-cert-${REGION}"

print_test "${PKG} is installed"
if ! rpm -qa "${PKG}" >/dev/null; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: regional version of secprod-pki-root-ca-cert package is not installed "
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: install regional version of secprod-pki-root-ca-cert"
    echo "!! For non Evergreen hosts only !!"
    echo "yum install ${PKG}"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK \n"
    if [[ $REGION == "*" ]]; then
        PKG=$(rpm -qa "${PKG}")
        printf "    %s \n" "${PKG}"
    fi
fi

print_test "/etc/oci-pki/ca-bundle.pem is accessible"
if [[ ! -f "/etc/oci-pki/ca-bundle.pem" ]]; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: package ${PKG} is installed but /etc/oci-pki/ca-bundle.pem is missing"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: reinstall regional version of secprod-pki-root-ca-cert or contact PKI team for assistance"
    echo "!! For non Evergreen hosts only !!"
    echo "yum install ${PKG}"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK \n"
fi

# ROOTFS is readonly
print_test "root filesystem is mounted read-write"
if ! grep -qE "/dev/.* / .* rw," /proc/mounts; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: ROOTFS is not mounted read-write"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: fix root filesystem. A reboot may be required"
    echo "!! For non Evergreen instance only !!"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

############################################################
#                griffin_config_downloader                 #
############################################################

# griffin_config_downloader.service is missing
print_test "configuration downloader griffin_config_downloader.service is active"
if ! systemctl is-enabled griffin_config_downloader.service --quiet; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: griffin_config_downloader.service is not enabled or missing "
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution:"
    echo "!! For non Evergreen instance only !!"
    echo "1. check if the service is present"
    echo "  systemctl status griffin_config_downloader.service"
    echo "2a. enable the service if present"
    echo "  systemctl enable griffin_config_downloader.service"
    echo "2b. resintall the agent if not present:"
    echo "  yum reinstall telemetry-unified-agent-griffin"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# griffin_config_downloader.service is missing or disabled
print_test "configuration downloader griffin_config_downloader.timer is active"
if ! systemctl is-enabled griffin_config_downloader.timer --quiet; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: griffin_config_downloader.service is not enabled or missing "
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution:"
    echo "!! For non Evergreen instance only !!"
    echo "1. check if the service is present"
    echo "  systemctl status griffin_config_downloader.timer"
    echo "2a. enable the service if present"
    echo "  systemctl enable griffin_config_downloader.timer"
    echo "2b. resintall the agent if not present:"
    echo "  yum reinstall telemetry-unified-agent-griffin"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif ! systemctl is-active griffin_config_downloader.timer --quiet; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: griffin_config_downloader.timer is disabled"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: enable service"
    echo "!! For non Evergreen instance only !!"
    echo "systemctl enable griffin_config_downloader.timer"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# Empty config_validity.txt
print_test "configuration file /etc/griffin/config_validity.txt is valid"
CONFIG_VALIDITY=$(cat /etc/griffin/config_validity.txt 2>/dev/null)
if [[ -f "/etc/griffin/config_validity.tx" ]] && [[ ${CONFIG_VALIDITY} == "" ]]; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: /etc/griffin/config_validity.txt is empty "
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: delete /etc/griffin/config_validity.txt"
    echo "rm /etc/griffin/config_validity.txt"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# Failure to connect to the service endpoint
# We finally check if we get "Finish writing config into file" which indicates log has been download and written
# as journal log is rotating and CP response may not be available
print_test "configuration downloader can connect to service endpoint"
if grep -q "getaddrinfo: Name or service not known" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: getaddrinfo: Name or service not known"
    grep "getaddrinfo: Name or service not known" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage COM for instance in overlay or SCCP in service enclave for issues related to DNS and smartNIC"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif grep -q "Failed to open TCP connection to 169.254.169.254:80" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: Failed to open TCP connection to 169.254.169.254:80"
    grep "Failed to open TCP connection to 169.254.169.254:80" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage COM for instance in overlay or SCCP in service enclave for issues related to smartNIC"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif ! grep -q "Successfully get response from CP" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" && ! grep -q "Finish writing config into file" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: haven't found valid message indicating we received response from service endpoint"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# Failure to download config
print_test "configuration downloader can process request from logging endpoint"
if grep -q "Authorization failed or requested resource not found" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: Authorization failed or requested resource not found"
    grep "Authorization failed or requested resource not found" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: Go to https://devops.oci.oraclecorp.com/runbooks/SIEM/siem-runbooks-griffin-agent/siem-griffin-agent-troubleshooting"
    echo "Find solution under Failure to download config with \"NotAuthorizedOrNotFound\" or \"execution expired\""
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif grep -q "execution expired" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: execution expired;"
    grep "execution expired" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: Go to https://devops.oci.oraclecorp.com/runbooks/SIEM/siem-runbooks-griffin-agent/siem-griffin-agent-troubleshooting"
    echo "Find solution under Failure to download config with \"NotAuthorizedOrNotFound\" or \"execution expired\""
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif grep -q "Failed to download config from cp due to exception" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: Failed to download config from cp due to exception"
    grep "Failed to download config from cp due to exception" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# Failure to manage configuration file
print_test "configuration downloader can write new configuration"
if grep -q "No such file or directory @ rb_sysopen - /etc/griffintmp/ne" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: /etc/griffintmp created during the installation of the telemetry-unified-agent-griffin is missing"
    grep "No such file or directory @ rb_sysopen - /etc/griffintmp/ne" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: Go to https://devops.oci.oraclecorp.com/runbooks/SIEM/siem-runbooks-griffin-agent/siem-griffin-agent-troubleshooting"
    echo "Find solution under Failure to download config with \"No such file or directory @ rb_sysopen - /etc/griffintmp/\""
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif grep -q "Read-only file system @ rb_sysopen - /etc/griffintmp/ne" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: /etc/griffintmp can't be created as ROOT filesystem is read-only"
    grep "Read-only file system @ rb_sysopen - /etc/griffintmp/ne" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: check why your ROOT filesystem is read-only, reboot will be required to change it to read-write"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif grep -q "block in diff_between_new_and_old_config" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: old configuration file is missing"
    grep "block in diff_between_new_and_old_config" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: Go to https://devops.oci.oraclecorp.com/runbooks/SIEM/siem-runbooks-griffin-agent/siem-griffin-agent-troubleshooting"
    echo "Find solution under Failure to download config with error in \"diff_between_new_and_old_config\" (griffin < 2.6.10)"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# Failure to connect to the service endpoint
print_test "configuration downloader is running successfully"
if grep -qE "ERROR|FAILURE|griffin_config_downloader.service failed" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"; then
    printf "WARNING\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Warning: unexpected ERROR/FAILURE reported by griffin_config_downloader.service journal log"
    grep -E "ERROR|FAILURE|griffin_config_downloader.service failed" "$GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

print_test "configuration file /etc/griffin/conf.d/${HOSTCLASS}/fluentd.conf is present"
if [[ ! -f "/etc/griffin/conf.d/${HOSTCLASS}/fluentd.conf" ]]; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: /etc/griffin/conf.d/${HOSTCLASS}/fluentd.conf is not present"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

############################################################
#                griffin_agent                             #
############################################################

# Failure caused by "plugin already use same buffer path"
print_test "configuration file /etc/griffin/conf.d/${HOSTCLASS}/fluentd.conf is valid"
if grep -q "plugin already use same buffer path" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: found symtpom of multiple configuration using same buffer in /etc/griffin/conf.d/${HOSTCLASS}/fluentd.conf"
    grep "plugin already use same buffer path" "$GRIFFIN_TEMP_LOG_PATH"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: Go to https://devops.oci.oraclecorp.com/runbooks/SIEM/siem-runbooks-griffin-agent/siem-griffin-agent-troubleshooting"
    echo "Find solution under Failure caused by \"plugin already use same buffer path\"."
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# griffin.service is missing or disabled
print_test "agent service griffin.service is active"
if ! systemctl is-enabled griffin.service --quiet; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: griffin.service is not enabled or missing "
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution:"
    echo "!! For non Evergreen instance only !!"
    echo "1. check if the service is present"
    echo "  systemctl status griffin.service"
    echo "2a. enable the service if present"
    echo "  systemctl enable griffin.service"
    echo "2b. resintall the agent if not present:"
    echo "  yum reinstall telemetry-unified-agent-griffin"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif ! systemctl is-active griffin.service --quiet; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: griffin.service is disabled or in failed state"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: restart the service"
    echo "!! For non Evergreen instance only !!"
    echo "systemctl disable griffin.service"
    echo "systemctl enable griffin.service"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# Failure to connect to the service endpoint
print_test "agent can send request to logging endpoint"
if grep -q "'message': 'execution expired'" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: Failure caused by \"execution expired\""
    grep "'message': 'execution expired'" "$GRIFFIN_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: Go to https://devops.oci.oraclecorp.com/runbooks/SIEM/siem-runbooks-griffin-agent/siem-griffin-agent-troubleshooting"
    echo "Find solution under Failure caused by \"execution expired\"."
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif grep -q "SSL_connect returned=1 errno=0 state=error: certificate verify failed" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: fail to connect to the service endpoint or SSL errors"
    grep "SSL_connect returned=1 errno=0 state=error: certificate verify failed" "$GRIFFIN_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: Go to https://devops.oci.oraclecorp.com/runbooks/SIEM/siem-runbooks-griffin-agent/siem-griffin-agent-troubleshooting"
    echo "Find solution under The Griffn agent and/or downloader are reporting failures to connect to the service endpoint or SSL errors"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif grep -q "getaddrinfo: Name or service not known" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: fail to connect to the service endpoint due to DNS error"
    grep "getaddrinfo: Name or service not known" "$GRIFFIN_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage COM for instance in overlay or SCCP in service enclave for issues related to smartNIC"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif grep -q "Failed to open TCP connection to 169.254.169.254:80" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: fail to connect to the service endpoint due to smartNIC timeout "
    grep "Failed to open TCP connection to 169.254.169.254:80" "$GRIFFIN_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage COM for instance in overlay or SCCP in service enclave for issues related to smartNIC"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
elif ! grep -qE "Logstream add definition response 200|response .* request metadata" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "WARNING\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Warning: no valid response found from service endpoint"
    grep -E "Logstream add definition response 200|response .* request metadata" "$GRIFFIN_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: retry script in 10 minutes or engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# AuditD is enabled
print_test "AuditD is enabled in grub"
if ! grep -q "audit=1" /proc/cmdline >/dev/null; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: audit is disabled in the grub boot configuration "
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage your image team to enable audit feature in grub"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# AuditD service is active
print_test "AuditD OCI rules are present"
if [[ ! -f /etc/audit/audit.rules ]] || ! grep -qi dart /etc/audit/audit.rules; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: /etc/audit/audit.rules is not present or is not configured according to OCI Security standard"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: if host is Chef managed ensure Chef ran successfully otherwise engage SIEM team"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# AuditD service is active
print_test "AuditD service is active"
if ! systemctl is-active auditd.service --quiet; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: auditd service is disabled or in failed state"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: if host is Chef manage engage ICM team"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

print_test "AuditD log file is recent"
if ! find /var/log/audit -type f -name audit.log -mtime -60 | grep -q "audit.log"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: /var/log/audit.log has not been updated within the last 60 minutes"
    ls -lh /var/log/audit
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: if host is Chef manage engage ICM team"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# auditd filter is having error causing events to be dropped
print_test "AuditD logs are not dropped by agent filter issues"
if grep -q "dropping record, no auditd" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Error: AuditD filter is dropping events"
    grep "dropping record, no auditd" "$GRIFFIN_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# Agent is sending auditd logs
print_test "AuditD logs are sent by the agent"
if ! grep -qE "response 204.*/var/log/audit/audit.log" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "WARNING\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Warning: not able to find valid response for /var/log/audit/audit.log"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: check the file /var/log/audit/audit.log exists then engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# no issue with chunck
print_test "agent is not reporting issues sending log"
# We don't want to look at chunk size limit emitted by metric plugin
if grep -v "chunk size limit exceeds for an emitted event stream" "$GRIFFIN_TEMP_LOG_PATH" | grep -qiE "warn.*chunk|err.*chunk"; then
    printf "WARNING\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Warning: agent is reporting issues sending logs"
    grep -iE "warn.*chunk|err.*chunk" "$GRIFFIN_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: for error 429 which means Logging is throttling request you can disregard the warning."
    echo ""
    echo "Solution: for error 404 NOT AUTHORIZED follow policy setup for overlay in https://devops.oci.oraclecorp.com/runbooks/SIEM/siem-runbooks-griffin-agent/siem-griffin-agent-onboarding"
    echo ""
    echo "For other messages engage SIEM and provide the collected log files."
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# Check we are sending metrics
# We have different message for service and overlay
print_test "agent is sending metrics"
if ! grep -qE "OCI monitoring post metrics response status: 200|T2 post metrics response status: 200" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "WARNING\n"
    echo "--------------------------------------- WARNING ----------------------------------"
    echo "Warning: found no valid response for monitoring post metrics"
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# no runtime issues
print_test "agent is not reporting runtime issues"
if grep -qiE "\[(warn|err).*(error_class|nil|undefined|block in)|exception" "$GRIFFIN_TEMP_LOG_PATH"; then
    printf "ERROR\n"
    echo "--------------------------------------- Error $((++ERROR_NUM))----------------------------------"
    echo "Warning: agent is reporting runtime issues"
    grep -iE "\[(warn|err).*(error_class|nil|undefined|block in)|exception" "$GRIFFIN_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# pattern not matched
print_test "agent is not reporting pattern matching warning"
if grep -q "pattern not matched" "$GRIFFIN_TEMP_LOG_PATH" 2>/dev/null; then
    printf "WARNING\n"
    echo "--------------------------------------- Warning ----------------------------------"
    echo "Warning: found 'pattern not matched' warning which can cause security findings"
    grep "pattern not matched" "$GRIFFIN_TEMP_LOG_PATH" | tail -15
    echo "--------------------------------------- Solution -----------------------------------------------"
    echo "Solution: engage SIEM and provide the collected log files"
    echo -e "---------------------------------------- End ---------------------------------------------------\n"
else
    printf "OK\n"
fi

# No error above. Cut ticket to SIEM team
if [ "$ERROR_NUM" -eq 0 ]; then
    echo -e "\n==== Found no specific error ====\n"
fi

echo -e "\n ** For assistance please cut a SEV-3 ticket to SIEM team and provide following information - DO NOT CUT A SEV2 TICKET since this will not be treated as a SEV2 for the SIEM team  **"
echo "      * !! include console output of this script !!"
echo "      * attach following files:"
echo "          $GRIFFIN_DOCTOR_TEMP_LOG_PATH"
echo "          $GRIFFIN_TEMP_LOG_PATH"
echo "          $GRIFFIN_CONFIG_DOWNLOADER_TEMP_LOG_PATH"
echo ""
