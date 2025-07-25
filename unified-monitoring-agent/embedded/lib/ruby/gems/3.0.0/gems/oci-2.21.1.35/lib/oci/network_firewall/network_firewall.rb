# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230501

module OCI
  module NetworkFirewall
    # Module containing models for requests made to, and responses received from,
    # OCI NetworkFirewall services
    module Models
    end
  end
end

# Require models
require 'oci/network_firewall/models/action_type'
require 'oci/network_firewall/models/address_list'
require 'oci/network_firewall/models/address_list_summary'
require 'oci/network_firewall/models/address_list_summary_collection'
require 'oci/network_firewall/models/address_list_type'
require 'oci/network_firewall/models/app_type'
require 'oci/network_firewall/models/application'
require 'oci/network_firewall/models/application_group'
require 'oci/network_firewall/models/application_group_summary'
require 'oci/network_firewall/models/application_group_summary_collection'
require 'oci/network_firewall/models/application_summary'
require 'oci/network_firewall/models/application_summary_collection'
require 'oci/network_firewall/models/apply_network_firewall_policy_details'
require 'oci/network_firewall/models/change_network_firewall_compartment_details'
require 'oci/network_firewall/models/change_network_firewall_policy_compartment_details'
require 'oci/network_firewall/models/clone_network_firewall_policy_details'
require 'oci/network_firewall/models/create_address_list_details'
require 'oci/network_firewall/models/create_application_details'
require 'oci/network_firewall/models/create_application_group_details'
require 'oci/network_firewall/models/create_decryption_profile_details'
require 'oci/network_firewall/models/create_decryption_rule_details'
require 'oci/network_firewall/models/create_icmp6_application_details'
require 'oci/network_firewall/models/create_icmp_application_details'
require 'oci/network_firewall/models/create_mapped_secret_details'
require 'oci/network_firewall/models/create_network_firewall_details'
require 'oci/network_firewall/models/create_network_firewall_policy_details'
require 'oci/network_firewall/models/create_security_rule_details'
require 'oci/network_firewall/models/create_service_details'
require 'oci/network_firewall/models/create_service_list_details'
require 'oci/network_firewall/models/create_ssl_forward_proxy_profile_details'
require 'oci/network_firewall/models/create_ssl_inbound_inspection_profile_details'
require 'oci/network_firewall/models/create_tcp_service_details'
require 'oci/network_firewall/models/create_tunnel_inspection_rule_details'
require 'oci/network_firewall/models/create_udp_service_details'
require 'oci/network_firewall/models/create_url_list_details'
require 'oci/network_firewall/models/create_vault_mapped_secret_details'
require 'oci/network_firewall/models/create_vxlan_inspection_rule_details'
require 'oci/network_firewall/models/decryption_action_type'
require 'oci/network_firewall/models/decryption_profile'
require 'oci/network_firewall/models/decryption_profile_summary'
require 'oci/network_firewall/models/decryption_profile_summary_collection'
require 'oci/network_firewall/models/decryption_rule'
require 'oci/network_firewall/models/decryption_rule_match_criteria'
require 'oci/network_firewall/models/decryption_rule_summary'
require 'oci/network_firewall/models/decryption_rule_summary_collection'
require 'oci/network_firewall/models/icmp6_application'
require 'oci/network_firewall/models/icmp6_application_summary'
require 'oci/network_firewall/models/icmp_application'
require 'oci/network_firewall/models/icmp_application_summary'
require 'oci/network_firewall/models/inspect_action_type'
require 'oci/network_firewall/models/inspection_type'
require 'oci/network_firewall/models/lifecycle_state'
require 'oci/network_firewall/models/mapped_secret'
require 'oci/network_firewall/models/mapped_secret_summary'
require 'oci/network_firewall/models/mapped_secret_summary_collection'
require 'oci/network_firewall/models/mapped_secret_type'
require 'oci/network_firewall/models/network_firewall'
require 'oci/network_firewall/models/network_firewall_collection'
require 'oci/network_firewall/models/network_firewall_policy'
require 'oci/network_firewall/models/network_firewall_policy_summary'
require 'oci/network_firewall/models/network_firewall_policy_summary_collection'
require 'oci/network_firewall/models/network_firewall_summary'
require 'oci/network_firewall/models/operation_status'
require 'oci/network_firewall/models/operation_type'
require 'oci/network_firewall/models/port_range'
require 'oci/network_firewall/models/rule_position'
require 'oci/network_firewall/models/security_rule'
require 'oci/network_firewall/models/security_rule_match_criteria'
require 'oci/network_firewall/models/security_rule_summary'
require 'oci/network_firewall/models/security_rule_summary_collection'
require 'oci/network_firewall/models/service'
require 'oci/network_firewall/models/service_list'
require 'oci/network_firewall/models/service_list_summary'
require 'oci/network_firewall/models/service_list_summary_collection'
require 'oci/network_firewall/models/service_summary'
require 'oci/network_firewall/models/service_summary_collection'
require 'oci/network_firewall/models/service_type'
require 'oci/network_firewall/models/simple_url_pattern'
require 'oci/network_firewall/models/sort_order'
require 'oci/network_firewall/models/ssl_forward_proxy_profile'
require 'oci/network_firewall/models/ssl_inbound_inspection_profile'
require 'oci/network_firewall/models/tcp_service'
require 'oci/network_firewall/models/traffic_action_type'
require 'oci/network_firewall/models/traffic_inspection_type'
require 'oci/network_firewall/models/tunnel_inspection_protocol'
require 'oci/network_firewall/models/tunnel_inspection_rule'
require 'oci/network_firewall/models/tunnel_inspection_rule_summary'
require 'oci/network_firewall/models/tunnel_inspection_rule_summary_collection'
require 'oci/network_firewall/models/udp_service'
require 'oci/network_firewall/models/update_address_list_details'
require 'oci/network_firewall/models/update_application_details'
require 'oci/network_firewall/models/update_application_group_details'
require 'oci/network_firewall/models/update_decryption_profile_details'
require 'oci/network_firewall/models/update_decryption_rule_details'
require 'oci/network_firewall/models/update_fqdn_address_list_details'
require 'oci/network_firewall/models/update_icmp6_application_details'
require 'oci/network_firewall/models/update_icmp_application_details'
require 'oci/network_firewall/models/update_ip_address_list_details'
require 'oci/network_firewall/models/update_mapped_secret_details'
require 'oci/network_firewall/models/update_network_firewall_details'
require 'oci/network_firewall/models/update_network_firewall_policy_details'
require 'oci/network_firewall/models/update_security_rule_details'
require 'oci/network_firewall/models/update_service_details'
require 'oci/network_firewall/models/update_service_list_details'
require 'oci/network_firewall/models/update_ssl_forward_proxy_profile_details'
require 'oci/network_firewall/models/update_ssl_inbound_inspection_profile_details'
require 'oci/network_firewall/models/update_tcp_service_details'
require 'oci/network_firewall/models/update_tunnel_inspection_rule_details'
require 'oci/network_firewall/models/update_udp_service_details'
require 'oci/network_firewall/models/update_url_list_details'
require 'oci/network_firewall/models/update_vault_mapped_secret_details'
require 'oci/network_firewall/models/update_vxlan_inspection_rule_details'
require 'oci/network_firewall/models/url_list'
require 'oci/network_firewall/models/url_list_summary'
require 'oci/network_firewall/models/url_list_summary_collection'
require 'oci/network_firewall/models/url_pattern'
require 'oci/network_firewall/models/vault_mapped_secret'
require 'oci/network_firewall/models/vxlan_inspection_rule'
require 'oci/network_firewall/models/vxlan_inspection_rule_match_criteria'
require 'oci/network_firewall/models/vxlan_inspection_rule_profile'
require 'oci/network_firewall/models/vxlan_inspection_rule_summary'
require 'oci/network_firewall/models/work_request'
require 'oci/network_firewall/models/work_request_error'
require 'oci/network_firewall/models/work_request_error_collection'
require 'oci/network_firewall/models/work_request_log_entry'
require 'oci/network_firewall/models/work_request_log_entry_collection'
require 'oci/network_firewall/models/work_request_resource'
require 'oci/network_firewall/models/work_request_resource_metadata_key'
require 'oci/network_firewall/models/work_request_summary'
require 'oci/network_firewall/models/work_request_summary_collection'

# Require generated clients
require 'oci/network_firewall/network_firewall_client'
require 'oci/network_firewall/network_firewall_client_composite_operations'

# Require service utilities
require 'oci/network_firewall/util'
