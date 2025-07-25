# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20170115

module OCI
  module LoadBalancer
    # Module containing models for requests made to, and responses received from,
    # OCI LoadBalancer services
    module Models
    end
  end
end

# Require models
require 'oci/load_balancer/models/action'
require 'oci/load_balancer/models/add_http_request_header_rule'
require 'oci/load_balancer/models/add_http_response_header_rule'
require 'oci/load_balancer/models/allow_rule'
require 'oci/load_balancer/models/backend'
require 'oci/load_balancer/models/backend_details'
require 'oci/load_balancer/models/backend_health'
require 'oci/load_balancer/models/backend_set'
require 'oci/load_balancer/models/backend_set_details'
require 'oci/load_balancer/models/backend_set_health'
require 'oci/load_balancer/models/certificate'
require 'oci/load_balancer/models/certificate_details'
require 'oci/load_balancer/models/change_load_balancer_compartment_details'
require 'oci/load_balancer/models/connection_configuration'
require 'oci/load_balancer/models/control_access_using_http_methods_rule'
require 'oci/load_balancer/models/create_backend_details'
require 'oci/load_balancer/models/create_backend_set_details'
require 'oci/load_balancer/models/create_certificate_details'
require 'oci/load_balancer/models/create_hostname_details'
require 'oci/load_balancer/models/create_listener_details'
require 'oci/load_balancer/models/create_load_balancer_details'
require 'oci/load_balancer/models/create_path_route_set_details'
require 'oci/load_balancer/models/create_routing_policy_details'
require 'oci/load_balancer/models/create_rule_set_details'
require 'oci/load_balancer/models/create_ssl_cipher_suite_details'
require 'oci/load_balancer/models/extend_http_request_header_value_rule'
require 'oci/load_balancer/models/extend_http_response_header_value_rule'
require 'oci/load_balancer/models/forward_to_backend_set'
require 'oci/load_balancer/models/health_check_result'
require 'oci/load_balancer/models/health_checker'
require 'oci/load_balancer/models/health_checker_details'
require 'oci/load_balancer/models/hostname'
require 'oci/load_balancer/models/hostname_details'
require 'oci/load_balancer/models/http_header_rule'
require 'oci/load_balancer/models/ip_address'
require 'oci/load_balancer/models/ip_based_max_connections_rule'
require 'oci/load_balancer/models/ip_max_connections'
require 'oci/load_balancer/models/lb_cookie_session_persistence_configuration_details'
require 'oci/load_balancer/models/listener'
require 'oci/load_balancer/models/listener_details'
require 'oci/load_balancer/models/listener_rule_summary'
require 'oci/load_balancer/models/load_balancer'
require 'oci/load_balancer/models/load_balancer_health'
require 'oci/load_balancer/models/load_balancer_health_summary'
require 'oci/load_balancer/models/load_balancer_policy'
require 'oci/load_balancer/models/load_balancer_protocol'
require 'oci/load_balancer/models/load_balancer_shape'
require 'oci/load_balancer/models/path_match_condition'
require 'oci/load_balancer/models/path_match_type'
require 'oci/load_balancer/models/path_route'
require 'oci/load_balancer/models/path_route_set'
require 'oci/load_balancer/models/path_route_set_details'
require 'oci/load_balancer/models/redirect_rule'
require 'oci/load_balancer/models/redirect_uri'
require 'oci/load_balancer/models/remove_http_request_header_rule'
require 'oci/load_balancer/models/remove_http_response_header_rule'
require 'oci/load_balancer/models/reserved_ip'
require 'oci/load_balancer/models/routing_policy'
require 'oci/load_balancer/models/routing_policy_details'
require 'oci/load_balancer/models/routing_rule'
require 'oci/load_balancer/models/rule'
require 'oci/load_balancer/models/rule_condition'
require 'oci/load_balancer/models/rule_set'
require 'oci/load_balancer/models/rule_set_details'
require 'oci/load_balancer/models/ssl_cipher_suite'
require 'oci/load_balancer/models/ssl_cipher_suite_details'
require 'oci/load_balancer/models/ssl_configuration'
require 'oci/load_balancer/models/ssl_configuration_details'
require 'oci/load_balancer/models/session_persistence_configuration_details'
require 'oci/load_balancer/models/shape_details'
require 'oci/load_balancer/models/source_ip_address_condition'
require 'oci/load_balancer/models/source_vcn_id_condition'
require 'oci/load_balancer/models/source_vcn_ip_address_condition'
require 'oci/load_balancer/models/update_backend_details'
require 'oci/load_balancer/models/update_backend_set_details'
require 'oci/load_balancer/models/update_health_checker_details'
require 'oci/load_balancer/models/update_hostname_details'
require 'oci/load_balancer/models/update_listener_details'
require 'oci/load_balancer/models/update_load_balancer_details'
require 'oci/load_balancer/models/update_load_balancer_shape_details'
require 'oci/load_balancer/models/update_network_security_groups_details'
require 'oci/load_balancer/models/update_path_route_set_details'
require 'oci/load_balancer/models/update_routing_policy_details'
require 'oci/load_balancer/models/update_rule_set_details'
require 'oci/load_balancer/models/update_ssl_cipher_suite_details'
require 'oci/load_balancer/models/work_request'
require 'oci/load_balancer/models/work_request_error'

# Require generated clients
require 'oci/load_balancer/load_balancer_client'
require 'oci/load_balancer/load_balancer_client_composite_operations'

# Require service utilities
require 'oci/load_balancer/util'
