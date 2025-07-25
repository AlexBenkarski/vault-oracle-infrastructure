# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20190531

module OCI
  module Bds
    # Module containing models for requests made to, and responses received from,
    # OCI Bds services
    module Models
    end
  end
end

# Require models
require 'oci/bds/models/action_types'
require 'oci/bds/models/activate_bds_metastore_configuration_details'
require 'oci/bds/models/add_auto_scale_policy_details'
require 'oci/bds/models/add_auto_scaling_configuration_details'
require 'oci/bds/models/add_block_storage_details'
require 'oci/bds/models/add_cloud_sql_details'
require 'oci/bds/models/add_kafka_details'
require 'oci/bds/models/add_master_nodes_details'
require 'oci/bds/models/add_metric_based_horizontal_scaling_policy_details'
require 'oci/bds/models/add_metric_based_vertical_scaling_policy_details'
require 'oci/bds/models/add_schedule_based_horizontal_scaling_policy_details'
require 'oci/bds/models/add_schedule_based_vertical_scaling_policy_details'
require 'oci/bds/models/add_utility_nodes_details'
require 'oci/bds/models/add_worker_nodes_details'
require 'oci/bds/models/auto_scale_policy'
require 'oci/bds/models/auto_scale_policy_details'
require 'oci/bds/models/auto_scale_policy_metric_rule'
require 'oci/bds/models/auto_scale_policy_rule'
require 'oci/bds/models/auto_scaling_configuration'
require 'oci/bds/models/auto_scaling_configuration_summary'
require 'oci/bds/models/backup_node_details'
require 'oci/bds/models/batching_based_odh_patching_config'
require 'oci/bds/models/batching_based_patching_configs'
require 'oci/bds/models/bds_api_key'
require 'oci/bds/models/bds_api_key_summary'
require 'oci/bds/models/bds_instance'
require 'oci/bds/models/bds_instance_summary'
require 'oci/bds/models/bds_metastore_configuration'
require 'oci/bds/models/bds_metastore_configuration_summary'
require 'oci/bds/models/certificate_service_info_details'
require 'oci/bds/models/certificate_service_info_summary'
require 'oci/bds/models/change_bds_instance_compartment_details'
require 'oci/bds/models/change_shape_details'
require 'oci/bds/models/change_shape_nodes'
require 'oci/bds/models/cloud_sql_details'
require 'oci/bds/models/cluster_details'
require 'oci/bds/models/create_bds_api_key_details'
require 'oci/bds/models/create_bds_instance_details'
require 'oci/bds/models/create_bds_metastore_configuration_details'
require 'oci/bds/models/create_node_backup_configuration_details'
require 'oci/bds/models/create_node_details'
require 'oci/bds/models/create_node_replace_configuration_details'
require 'oci/bds/models/create_resource_principal_configuration_details'
require 'oci/bds/models/day_based_horizontal_scaling_schedule_details'
require 'oci/bds/models/day_based_vertical_scaling_schedule_details'
require 'oci/bds/models/default_error'
require 'oci/bds/models/disable_certificate_details'
require 'oci/bds/models/domain_based_odh_patching_config'
require 'oci/bds/models/domain_based_patching_configs'
require 'oci/bds/models/downtime_based_odh_patching_config'
require 'oci/bds/models/downtime_based_patching_configs'
require 'oci/bds/models/enable_certificate_details'
require 'oci/bds/models/execute_bootstrap_script_details'
require 'oci/bds/models/force_refresh_resource_principal_details'
require 'oci/bds/models/horizontal_scaling_schedule_details'
require 'oci/bds/models/host_cert_details'
require 'oci/bds/models/host_specific_certificate_details'
require 'oci/bds/models/install_os_patch_details'
require 'oci/bds/models/install_patch_details'
require 'oci/bds/models/kerberos_details'
require 'oci/bds/models/level_type_details'
require 'oci/bds/models/metric_based_horizontal_scale_in_config'
require 'oci/bds/models/metric_based_horizontal_scale_out_config'
require 'oci/bds/models/metric_based_horizontal_scaling_policy_details'
require 'oci/bds/models/metric_based_vertical_scale_down_config'
require 'oci/bds/models/metric_based_vertical_scale_up_config'
require 'oci/bds/models/metric_based_vertical_scaling_policy_details'
require 'oci/bds/models/metric_threshold_rule'
require 'oci/bds/models/network_config'
require 'oci/bds/models/node'
require 'oci/bds/models/node_backup'
require 'oci/bds/models/node_backup_configuration'
require 'oci/bds/models/node_backup_configuration_summary'
require 'oci/bds/models/node_backup_summary'
require 'oci/bds/models/node_level_details'
require 'oci/bds/models/node_replace_configuration'
require 'oci/bds/models/node_replace_configuration_summary'
require 'oci/bds/models/node_type_level_details'
require 'oci/bds/models/odh_patching_config'
require 'oci/bds/models/operation_status'
require 'oci/bds/models/operation_types'
require 'oci/bds/models/os_patch_details'
require 'oci/bds/models/os_patch_package_summary'
require 'oci/bds/models/os_patch_summary'
require 'oci/bds/models/patch_history_summary'
require 'oci/bds/models/patch_summary'
require 'oci/bds/models/patching_configs'
require 'oci/bds/models/remove_auto_scaling_configuration_details'
require 'oci/bds/models/remove_cloud_sql_details'
require 'oci/bds/models/remove_kafka_details'
require 'oci/bds/models/remove_node_details'
require 'oci/bds/models/remove_node_replace_configuration_details'
require 'oci/bds/models/remove_resource_principal_configuration_details'
require 'oci/bds/models/renew_certificate_details'
require 'oci/bds/models/replace_node_details'
require 'oci/bds/models/resource_principal_configuration'
require 'oci/bds/models/resource_principal_configuration_summary'
require 'oci/bds/models/restart_node_details'
require 'oci/bds/models/schedule_based_horizontal_scaling_policy_details'
require 'oci/bds/models/schedule_based_vertical_scaling_policy_details'
require 'oci/bds/models/schedule_type'
require 'oci/bds/models/service'
require 'oci/bds/models/shape_config_details'
require 'oci/bds/models/sort_orders'
require 'oci/bds/models/start_bds_instance_details'
require 'oci/bds/models/stop_bds_instance_details'
require 'oci/bds/models/test_bds_metastore_configuration_details'
require 'oci/bds/models/test_bds_object_storage_connection_details'
require 'oci/bds/models/time_and_horizontal_scaling_config'
require 'oci/bds/models/time_and_vertical_scaling_config'
require 'oci/bds/models/update_auto_scale_policy_details'
require 'oci/bds/models/update_auto_scaling_configuration_details'
require 'oci/bds/models/update_bds_instance_details'
require 'oci/bds/models/update_bds_metastore_configuration_details'
require 'oci/bds/models/update_metric_based_horizontal_scaling_policy_details'
require 'oci/bds/models/update_metric_based_vertical_scaling_policy_details'
require 'oci/bds/models/update_node_backup_configuration_details'
require 'oci/bds/models/update_node_replace_configuration_details'
require 'oci/bds/models/update_resource_principal_configuration_details'
require 'oci/bds/models/update_schedule_based_horizontal_scaling_policy_details'
require 'oci/bds/models/update_schedule_based_vertical_scaling_policy_details'
require 'oci/bds/models/vertical_scaling_schedule_details'
require 'oci/bds/models/volume_attachment_detail'
require 'oci/bds/models/work_request'
require 'oci/bds/models/work_request_error'
require 'oci/bds/models/work_request_log_entry'
require 'oci/bds/models/work_request_resource'

# Require generated clients
require 'oci/bds/bds_client'
require 'oci/bds/bds_client_composite_operations'

# Require service utilities
require 'oci/bds/util'
