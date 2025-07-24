#!/bin/bash

# Contact:
# Collect Griffin data for troubleshooting.

set -o nounset  # exit when using unset variables
set -o pipefail  # properly report failed pipes
set -x  # enable tracing

mkdir -p /etc/griffin/troubleshooting
GRIFFIN_LOG_PATH="/var/log/griffin/griffin.log"
LOGFILE=$(mktemp /etc/griffin/troubleshooting/griffin_agent_information_XXX) # create temp log file
OUTPUT_FILE="/tmp/griffin_agent_troubleshooting_logs_$(date +%s).tar.gz"
LOCKDIR="/tmp/$(basename $0)_lock_dir"  # used as a mutex
HAVE_LOCK=false
chmod 644 "$LOGFILE"

trap _exit EXIT  # set up error handling


###############################################################################
#                       FUNCTIONS START                                       #
###############################################################################

function logf
{ # $1 is message
        now=$(date +%X)
        echo "$now   $1"
}
#******************************************************************************
function _exit
{
    exit_code=$?

    # cleanup
    if "$HAVE_LOCK" == "true"  || ! mkdir "${LOCKDIR}" &>/dev/null
    then
        rmdir "$LOCKDIR"
    fi
    rm -f /etc/griffin/troubleshooting/griffin_agent_information_*

    # error reporting
    if [ $exit_code -ne 0 ]
    then
        exit 1
    fi
    exit 0
}
#******************************************************************************

function usage
{
    echo "Usage: $0 [OPTIONS]"
    echo "Collect Griffin Agent data for troubleshooting."
    echo "Locking, only one instance is allowed to run at a time."
}
#******************************************************************************

###############################################################################
#                       FUNCTIONS END                                         #
###############################################################################

###############################################################################
#                       SCRIPT LOGIC START                                    #
###############################################################################

exec 1<>$LOGFILE # Open stdout as $LOGFILE

logf "Starting on: $(date)"

# Only one instance can run at a time, lock by mkdir (ensured atomic)
if ! mkdir "${LOCKDIR}" &>/dev/null
then
    echo "Exiting, lock exists: $LOCKDIR"
    exit 1
else
    HAVE_LOCK=true
fi

GRIFFIN_INACTIVE=0
systemctl is-active griffin.service || GRIFFIN_INACTIVE=$?
if [ "$GRIFFIN_INACTIVE" -gt 0 ]
then
  # sleep 1min and check if griffin is still inactive
  sleep 60
  GRIFFIN_INACTIVE=0
  systemctl is-active griffin.service || GRIFFIN_INACTIVE=$?
  if [ "$GRIFFIN_INACTIVE" -gt 0 ]
  then
    logf "Step: Getting griffin version info"
    rpm -qa | grep griffin

    logf "Step: Getting systemctl status for griffin service"
    systemctl status --full griffin.service

    logf "Step: Getting journalctl logs for griffin service"
    journalctl -a --no-pager -u griffin.service --since "40min ago"

    logf "Step: Getting systemctl status for the config downloader service"
    systemctl status --full griffin_config_downloader.service
    logf "Step: Getting systemctl status for the config downloader timer"
    systemctl status --full griffin_config_downloader.timer
    logf "Step: Getting systemctl status for griffin restarter path"
    systemctl status --full griffin_restarter.path
    logf "Step: Getting journalctl logs for the config downloader service"
    journalctl -a --no-pager -u griffin_config_downloader.service
    logf "Step: Getting journalctl logs for config downloader timer"
    journalctl -a --no-pager -u griffin_config_downloader.timer
    logf "Step: Getting journalctl logs for griffin restarter path"
    journalctl -a --no-pager -u griffin_restarter.path

    tar cvzf "$OUTPUT_FILE" /var/log/griffin/ /var/log/messages $LOGFILE

    # kill processs
    /usr/bin/systemctl kill griffin
    /usr/bin/systemctl restart griffin

  fi
fi

# if griffin_config_downloader.service is in failed state, restart it
GRIFFIN_CONFIG_DOWNLOADER_FAILED=0
systemctl is-failed griffin_config_downloader.service || GRIFFIN_CONFIG_DOWNLOADER_FAILED=$?
if [ "$GRIFFIN_CONFIG_DOWNLOADER_FAILED" -eq 0 ]
then
  logf "griffin_config_downloader service is in failed state restarting it"
  /usr/bin/systemctl kill griffin_config_downloader
  /usr/bin/systemctl restart griffin_config_downloader
fi

# if griffin_config_downloader.service didn't run in last 2(7200 secs)hours restart it.
# Get the current timestamp in seconds
CURRENT_TIMESTAMP=$(date +%s)
LOG_TIMESTAMP_=$(systemctl show griffin_config_downloader.service --property=InactiveEnterTimestamp |  awk -F '=' '{print $2}' | date -f - +%s)
TIME_DIFFERENCE=$((CURRENT_TIMESTAMP - LOG_TIMESTAMP_))
if [ "$TIME_DIFFERENCE" -gt 7200 ]
then
  logf "Restarting griffin config downloader service"
  /usr/bin/systemctl kill griffin_config_downloader
  /usr/bin/systemctl restart griffin_config_downloader
fi

# Restarting griffin if hung
CURRENT_TIMESTAMP=$(date +%s)
LAST_UPDATED_TIME=$(stat -c %Y "$GRIFFIN_LOG_PATH")

# Calculate time difference in seconds
TIME_DIFFERENCE=$((CURRENT_TIMESTAMP - LAST_UPDATED_TIME))

# Check if it has hung for 50 minutes or more (3000 seconds)
if [ $TIME_DIFFERENCE -gt 3000 ]; then
  echo "Restarting griffin as it froze"
  # kill processs
  /usr/bin/systemctl kill griffin
  /usr/bin/systemctl restart griffin
fi
###############################################################################
#                       SCRIPT LOGIC END                                      #
###############################################################################
