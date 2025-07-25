# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20181201

module OCI
  module DataSafe
    # Module containing models for requests made to, and responses received from,
    # OCI DataSafe services
    module Models
    end
  end
end

# Require models
require 'oci/data_safe/models/access_type'
require 'oci/data_safe/models/activate_target_database_details'
require 'oci/data_safe/models/alert'
require 'oci/data_safe/models/alert_aggregation_items'
require 'oci/data_safe/models/alert_analytics_collection'
require 'oci/data_safe/models/alert_collection'
require 'oci/data_safe/models/alert_lifecycle_state'
require 'oci/data_safe/models/alert_policy'
require 'oci/data_safe/models/alert_policy_collection'
require 'oci/data_safe/models/alert_policy_lifecycle_state'
require 'oci/data_safe/models/alert_policy_rule'
require 'oci/data_safe/models/alert_policy_rule_collection'
require 'oci/data_safe/models/alert_policy_rule_lifecycle_state'
require 'oci/data_safe/models/alert_policy_rule_summary'
require 'oci/data_safe/models/alert_policy_summary'
require 'oci/data_safe/models/alert_policy_type'
require 'oci/data_safe/models/alert_severity'
require 'oci/data_safe/models/alert_status'
require 'oci/data_safe/models/alert_summary'
require 'oci/data_safe/models/alert_type'
require 'oci/data_safe/models/alerts_aggregation_dimension'
require 'oci/data_safe/models/alerts_update_details'
require 'oci/data_safe/models/apply_discovery_job_results_details'
require 'oci/data_safe/models/apply_sdm_masking_policy_difference_details'
require 'oci/data_safe/models/audit_archive_retrieval'
require 'oci/data_safe/models/audit_archive_retrieval_collection'
require 'oci/data_safe/models/audit_archive_retrieval_lifecycle_state'
require 'oci/data_safe/models/audit_archive_retrieval_summary'
require 'oci/data_safe/models/audit_conditions'
require 'oci/data_safe/models/audit_event_aggregation_dimensions'
require 'oci/data_safe/models/audit_event_aggregation_items'
require 'oci/data_safe/models/audit_event_analytics_collection'
require 'oci/data_safe/models/audit_event_collection'
require 'oci/data_safe/models/audit_event_summary'
require 'oci/data_safe/models/audit_policy'
require 'oci/data_safe/models/audit_policy_aggregation_items'
require 'oci/data_safe/models/audit_policy_analytic_collection'
require 'oci/data_safe/models/audit_policy_category'
require 'oci/data_safe/models/audit_policy_collection'
require 'oci/data_safe/models/audit_policy_dimensions'
require 'oci/data_safe/models/audit_policy_lifecycle_state'
require 'oci/data_safe/models/audit_policy_summary'
require 'oci/data_safe/models/audit_profile'
require 'oci/data_safe/models/audit_profile_aggregation_items'
require 'oci/data_safe/models/audit_profile_analytic_collection'
require 'oci/data_safe/models/audit_profile_collection'
require 'oci/data_safe/models/audit_profile_dimensions'
require 'oci/data_safe/models/audit_profile_lifecycle_state'
require 'oci/data_safe/models/audit_profile_summary'
require 'oci/data_safe/models/audit_specification'
require 'oci/data_safe/models/audit_trail'
require 'oci/data_safe/models/audit_trail_aggregation_items'
require 'oci/data_safe/models/audit_trail_analytic_collection'
require 'oci/data_safe/models/audit_trail_collection'
require 'oci/data_safe/models/audit_trail_dimensions'
require 'oci/data_safe/models/audit_trail_lifecycle_state'
require 'oci/data_safe/models/audit_trail_source'
require 'oci/data_safe/models/audit_trail_status'
require 'oci/data_safe/models/audit_trail_summary'
require 'oci/data_safe/models/autonomous_database_details'
require 'oci/data_safe/models/available_audit_volume_collection'
require 'oci/data_safe/models/available_audit_volume_summary'
require 'oci/data_safe/models/calculate_audit_volume_available_details'
require 'oci/data_safe/models/calculate_audit_volume_collected_details'
require 'oci/data_safe/models/change_alert_compartment_details'
require 'oci/data_safe/models/change_alert_policy_compartment_details'
require 'oci/data_safe/models/change_audit_archive_retrieval_compartment_details'
require 'oci/data_safe/models/change_audit_policy_compartment_details'
require 'oci/data_safe/models/change_audit_profile_compartment_details'
require 'oci/data_safe/models/change_data_safe_private_endpoint_compartment_details'
require 'oci/data_safe/models/change_database_security_config_compartment_details'
require 'oci/data_safe/models/change_discovery_job_compartment_details'
require 'oci/data_safe/models/change_library_masking_format_compartment_details'
require 'oci/data_safe/models/change_masking_policy_compartment_details'
require 'oci/data_safe/models/change_masking_policy_health_report_compartment_details'
require 'oci/data_safe/models/change_on_prem_connector_compartment_details'
require 'oci/data_safe/models/change_report_compartment_details'
require 'oci/data_safe/models/change_report_definition_compartment_details'
require 'oci/data_safe/models/change_retention_details'
require 'oci/data_safe/models/change_sdm_masking_policy_difference_compartment_details'
require 'oci/data_safe/models/change_security_assessment_compartment_details'
require 'oci/data_safe/models/change_security_policy_compartment_details'
require 'oci/data_safe/models/change_security_policy_deployment_compartment_details'
require 'oci/data_safe/models/change_sensitive_data_model_compartment_details'
require 'oci/data_safe/models/change_sensitive_type_compartment_details'
require 'oci/data_safe/models/change_sql_collection_compartment_details'
require 'oci/data_safe/models/change_sql_firewall_policy_compartment_details'
require 'oci/data_safe/models/change_target_alert_policy_association_compartment_details'
require 'oci/data_safe/models/change_target_database_compartment_details'
require 'oci/data_safe/models/change_user_assessment_compartment_details'
require 'oci/data_safe/models/collected_audit_volume_collection'
require 'oci/data_safe/models/collected_audit_volume_summary'
require 'oci/data_safe/models/column'
require 'oci/data_safe/models/column_filter'
require 'oci/data_safe/models/column_sorting'
require 'oci/data_safe/models/column_source_details'
require 'oci/data_safe/models/column_source_from_sdm_details'
require 'oci/data_safe/models/column_source_from_target_details'
require 'oci/data_safe/models/column_summary'
require 'oci/data_safe/models/compare_security_assessment_details'
require 'oci/data_safe/models/compare_user_assessment_details'
require 'oci/data_safe/models/compatible_formats_for_data_types'
require 'oci/data_safe/models/compatible_formats_for_sensitive_types'
require 'oci/data_safe/models/connection_option'
require 'oci/data_safe/models/create_alert_policy_details'
require 'oci/data_safe/models/create_alert_policy_rule_details'
require 'oci/data_safe/models/create_audit_archive_retrieval_details'
require 'oci/data_safe/models/create_audit_policy_details'
require 'oci/data_safe/models/create_audit_profile_details'
require 'oci/data_safe/models/create_column_source_details'
require 'oci/data_safe/models/create_column_source_from_sdm_details'
require 'oci/data_safe/models/create_column_source_from_target_details'
require 'oci/data_safe/models/create_data_safe_private_endpoint_details'
require 'oci/data_safe/models/create_discovery_job_details'
require 'oci/data_safe/models/create_library_masking_format_details'
require 'oci/data_safe/models/create_masking_column_details'
require 'oci/data_safe/models/create_masking_policy_details'
require 'oci/data_safe/models/create_on_prem_connector_details'
require 'oci/data_safe/models/create_peer_target_database_details'
require 'oci/data_safe/models/create_report_definition_details'
require 'oci/data_safe/models/create_sdm_masking_policy_difference_details'
require 'oci/data_safe/models/create_security_assessment_details'
require 'oci/data_safe/models/create_sensitive_category_details'
require 'oci/data_safe/models/create_sensitive_column_details'
require 'oci/data_safe/models/create_sensitive_data_model_details'
require 'oci/data_safe/models/create_sensitive_type_details'
require 'oci/data_safe/models/create_sensitive_type_pattern_details'
require 'oci/data_safe/models/create_sql_collection_details'
require 'oci/data_safe/models/create_target_alert_policy_association_details'
require 'oci/data_safe/models/create_target_database_details'
require 'oci/data_safe/models/create_user_assessment_details'
require 'oci/data_safe/models/credentials'
require 'oci/data_safe/models/data_model_format'
require 'oci/data_safe/models/data_safe_configuration'
require 'oci/data_safe/models/data_safe_private_endpoint'
require 'oci/data_safe/models/data_safe_private_endpoint_summary'
require 'oci/data_safe/models/database_cloud_service_details'
require 'oci/data_safe/models/database_details'
require 'oci/data_safe/models/database_security_config'
require 'oci/data_safe/models/database_security_config_collection'
require 'oci/data_safe/models/database_security_config_lifecycle_state'
require 'oci/data_safe/models/database_security_config_summary'
require 'oci/data_safe/models/database_table_access_entry'
require 'oci/data_safe/models/database_table_access_entry_collection'
require 'oci/data_safe/models/database_table_access_entry_summary'
require 'oci/data_safe/models/database_type'
require 'oci/data_safe/models/database_view_access_entry'
require 'oci/data_safe/models/database_view_access_entry_collection'
require 'oci/data_safe/models/database_view_access_entry_summary'
require 'oci/data_safe/models/delete_rows_format_entry'
require 'oci/data_safe/models/deterministic_encryption_date_format_entry'
require 'oci/data_safe/models/deterministic_encryption_format_entry'
require 'oci/data_safe/models/deterministic_substitution_format_entry'
require 'oci/data_safe/models/difference_column'
require 'oci/data_safe/models/difference_column_summary'
require 'oci/data_safe/models/diffs'
require 'oci/data_safe/models/dimensions'
require 'oci/data_safe/models/discovery_analytics_collection'
require 'oci/data_safe/models/discovery_analytics_summary'
require 'oci/data_safe/models/discovery_job'
require 'oci/data_safe/models/discovery_job_collection'
require 'oci/data_safe/models/discovery_job_result'
require 'oci/data_safe/models/discovery_job_result_collection'
require 'oci/data_safe/models/discovery_job_result_summary'
require 'oci/data_safe/models/discovery_job_summary'
require 'oci/data_safe/models/discovery_lifecycle_state'
require 'oci/data_safe/models/download_discovery_report_details'
require 'oci/data_safe/models/download_masking_log_details'
require 'oci/data_safe/models/download_masking_policy_details'
require 'oci/data_safe/models/download_masking_report_details'
require 'oci/data_safe/models/download_security_assessment_report_details'
require 'oci/data_safe/models/download_sensitive_data_model_details'
require 'oci/data_safe/models/download_user_assessment_report_details'
require 'oci/data_safe/models/enable_conditions'
require 'oci/data_safe/models/enable_data_safe_configuration_details'
require 'oci/data_safe/models/entry_details'
require 'oci/data_safe/models/finding'
require 'oci/data_safe/models/finding_analytics_collection'
require 'oci/data_safe/models/finding_analytics_dimensions'
require 'oci/data_safe/models/finding_analytics_summary'
require 'oci/data_safe/models/finding_lifecycle_state'
require 'oci/data_safe/models/finding_summary'
require 'oci/data_safe/models/findings_change_audit_log_collection'
require 'oci/data_safe/models/findings_change_audit_log_summary'
require 'oci/data_safe/models/firewall_policy_entry_details'
require 'oci/data_safe/models/fixed_number_format_entry'
require 'oci/data_safe/models/fixed_string_format_entry'
require 'oci/data_safe/models/format_entry'
require 'oci/data_safe/models/format_entry_type'
require 'oci/data_safe/models/format_summary'
require 'oci/data_safe/models/formats_for_data_type'
require 'oci/data_safe/models/formats_for_sensitive_type'
require 'oci/data_safe/models/generate_discovery_report_for_download_details'
require 'oci/data_safe/models/generate_health_report_details'
require 'oci/data_safe/models/generate_masking_policy_for_download_details'
require 'oci/data_safe/models/generate_masking_report_for_download_details'
require 'oci/data_safe/models/generate_on_prem_connector_configuration_details'
require 'oci/data_safe/models/generate_report_details'
require 'oci/data_safe/models/generate_security_assessment_report_details'
require 'oci/data_safe/models/generate_sensitive_data_model_for_download_details'
require 'oci/data_safe/models/generate_user_assessment_report_details'
require 'oci/data_safe/models/global_settings'
require 'oci/data_safe/models/grant_summary'
require 'oci/data_safe/models/infrastructure_type'
require 'oci/data_safe/models/initialization_parameter'
require 'oci/data_safe/models/installed_database_details'
require 'oci/data_safe/models/library_masking_format'
require 'oci/data_safe/models/library_masking_format_collection'
require 'oci/data_safe/models/library_masking_format_entry'
require 'oci/data_safe/models/library_masking_format_source'
require 'oci/data_safe/models/library_masking_format_summary'
require 'oci/data_safe/models/lifecycle_state'
require 'oci/data_safe/models/mask_data_details'
require 'oci/data_safe/models/masked_column_collection'
require 'oci/data_safe/models/masked_column_summary'
require 'oci/data_safe/models/masking_analytics_collection'
require 'oci/data_safe/models/masking_analytics_dimensions'
require 'oci/data_safe/models/masking_analytics_summary'
require 'oci/data_safe/models/masking_column'
require 'oci/data_safe/models/masking_column_collection'
require 'oci/data_safe/models/masking_column_lifecycle_state'
require 'oci/data_safe/models/masking_column_summary'
require 'oci/data_safe/models/masking_format'
require 'oci/data_safe/models/masking_lifecycle_state'
require 'oci/data_safe/models/masking_object_collection'
require 'oci/data_safe/models/masking_object_summary'
require 'oci/data_safe/models/masking_policy'
require 'oci/data_safe/models/masking_policy_collection'
require 'oci/data_safe/models/masking_policy_health_report'
require 'oci/data_safe/models/masking_policy_health_report_collection'
require 'oci/data_safe/models/masking_policy_health_report_log_collection'
require 'oci/data_safe/models/masking_policy_health_report_log_summary'
require 'oci/data_safe/models/masking_policy_health_report_summary'
require 'oci/data_safe/models/masking_policy_summary'
require 'oci/data_safe/models/masking_report'
require 'oci/data_safe/models/masking_report_collection'
require 'oci/data_safe/models/masking_report_summary'
require 'oci/data_safe/models/masking_schema_collection'
require 'oci/data_safe/models/masking_schema_summary'
require 'oci/data_safe/models/modified_attributes'
require 'oci/data_safe/models/modify_global_settings_details'
require 'oci/data_safe/models/null_value_format_entry'
require 'oci/data_safe/models/object_type'
require 'oci/data_safe/models/on_prem_connector'
require 'oci/data_safe/models/on_prem_connector_lifecycle_state'
require 'oci/data_safe/models/on_prem_connector_summary'
require 'oci/data_safe/models/on_premise_connector'
require 'oci/data_safe/models/ppf_format_entry'
require 'oci/data_safe/models/patch_alert_policy_rule_details'
require 'oci/data_safe/models/patch_alerts_details'
require 'oci/data_safe/models/patch_discovery_job_result_details'
require 'oci/data_safe/models/patch_insert_instruction'
require 'oci/data_safe/models/patch_instruction'
require 'oci/data_safe/models/patch_masking_columns_details'
require 'oci/data_safe/models/patch_merge_instruction'
require 'oci/data_safe/models/patch_remove_instruction'
require 'oci/data_safe/models/patch_sdm_masking_policy_difference_columns_details'
require 'oci/data_safe/models/patch_sensitive_column_details'
require 'oci/data_safe/models/patch_target_alert_policy_association_details'
require 'oci/data_safe/models/pattern_format_entry'
require 'oci/data_safe/models/peer_target_database'
require 'oci/data_safe/models/peer_target_database_collection'
require 'oci/data_safe/models/peer_target_database_summary'
require 'oci/data_safe/models/policy_format'
require 'oci/data_safe/models/preserve_original_data_format_entry'
require 'oci/data_safe/models/private_endpoint'
require 'oci/data_safe/models/privilege_grantable_option'
require 'oci/data_safe/models/privilege_name'
require 'oci/data_safe/models/profile'
require 'oci/data_safe/models/profile_aggregation'
require 'oci/data_safe/models/profile_details'
require 'oci/data_safe/models/profile_summary'
require 'oci/data_safe/models/provision_audit_conditions'
require 'oci/data_safe/models/provision_audit_policy_details'
require 'oci/data_safe/models/random_date_format_entry'
require 'oci/data_safe/models/random_decimal_number_format_entry'
require 'oci/data_safe/models/random_digits_format_entry'
require 'oci/data_safe/models/random_list_format_entry'
require 'oci/data_safe/models/random_number_format_entry'
require 'oci/data_safe/models/random_string_format_entry'
require 'oci/data_safe/models/random_substitution_format_entry'
require 'oci/data_safe/models/references'
require 'oci/data_safe/models/regular_expression_format_entry'
require 'oci/data_safe/models/report'
require 'oci/data_safe/models/report_collection'
require 'oci/data_safe/models/report_definition'
require 'oci/data_safe/models/report_definition_collection'
require 'oci/data_safe/models/report_definition_data_source'
require 'oci/data_safe/models/report_definition_lifecycle_state'
require 'oci/data_safe/models/report_definition_summary'
require 'oci/data_safe/models/report_details'
require 'oci/data_safe/models/report_lifecycle_state'
require 'oci/data_safe/models/report_summary'
require 'oci/data_safe/models/report_type'
require 'oci/data_safe/models/role_grant_path_collection'
require 'oci/data_safe/models/role_grant_path_summary'
require 'oci/data_safe/models/role_summary'
require 'oci/data_safe/models/run_security_assessment_details'
require 'oci/data_safe/models/run_user_assessment_details'
require 'oci/data_safe/models/sql_expression_format_entry'
require 'oci/data_safe/models/schedule_audit_report_details'
require 'oci/data_safe/models/schedule_report_details'
require 'oci/data_safe/models/schema_summary'
require 'oci/data_safe/models/sdm_masking_policy_difference'
require 'oci/data_safe/models/sdm_masking_policy_difference_collection'
require 'oci/data_safe/models/sdm_masking_policy_difference_column_collection'
require 'oci/data_safe/models/sdm_masking_policy_difference_summary'
require 'oci/data_safe/models/section_statistics'
require 'oci/data_safe/models/security_assessment'
require 'oci/data_safe/models/security_assessment_base_line_details'
require 'oci/data_safe/models/security_assessment_comparison'
require 'oci/data_safe/models/security_assessment_comparison_per_target'
require 'oci/data_safe/models/security_assessment_lifecycle_state'
require 'oci/data_safe/models/security_assessment_references'
require 'oci/data_safe/models/security_assessment_statistics'
require 'oci/data_safe/models/security_assessment_summary'
require 'oci/data_safe/models/security_feature_analytics_collection'
require 'oci/data_safe/models/security_feature_analytics_dimensions'
require 'oci/data_safe/models/security_feature_analytics_summary'
require 'oci/data_safe/models/security_feature_collection'
require 'oci/data_safe/models/security_feature_summary'
require 'oci/data_safe/models/security_policy'
require 'oci/data_safe/models/security_policy_collection'
require 'oci/data_safe/models/security_policy_deployment'
require 'oci/data_safe/models/security_policy_deployment_collection'
require 'oci/data_safe/models/security_policy_deployment_lifecycle_state'
require 'oci/data_safe/models/security_policy_deployment_summary'
require 'oci/data_safe/models/security_policy_entry_state'
require 'oci/data_safe/models/security_policy_entry_state_collection'
require 'oci/data_safe/models/security_policy_entry_state_deployment_status'
require 'oci/data_safe/models/security_policy_entry_state_summary'
require 'oci/data_safe/models/security_policy_lifecycle_state'
require 'oci/data_safe/models/security_policy_report'
require 'oci/data_safe/models/security_policy_report_collection'
require 'oci/data_safe/models/security_policy_report_lifecycle_state'
require 'oci/data_safe/models/security_policy_report_summary'
require 'oci/data_safe/models/security_policy_summary'
require 'oci/data_safe/models/sensitive_category'
require 'oci/data_safe/models/sensitive_column'
require 'oci/data_safe/models/sensitive_column_collection'
require 'oci/data_safe/models/sensitive_column_lifecycle_state'
require 'oci/data_safe/models/sensitive_column_summary'
require 'oci/data_safe/models/sensitive_data_model'
require 'oci/data_safe/models/sensitive_data_model_collection'
require 'oci/data_safe/models/sensitive_data_model_sensitive_type_collection'
require 'oci/data_safe/models/sensitive_data_model_sensitive_type_summary'
require 'oci/data_safe/models/sensitive_data_model_summary'
require 'oci/data_safe/models/sensitive_object_collection'
require 'oci/data_safe/models/sensitive_object_summary'
require 'oci/data_safe/models/sensitive_schema_collection'
require 'oci/data_safe/models/sensitive_schema_summary'
require 'oci/data_safe/models/sensitive_type'
require 'oci/data_safe/models/sensitive_type_collection'
require 'oci/data_safe/models/sensitive_type_entity'
require 'oci/data_safe/models/sensitive_type_pattern'
require 'oci/data_safe/models/sensitive_type_source'
require 'oci/data_safe/models/sensitive_type_summary'
require 'oci/data_safe/models/service_list'
require 'oci/data_safe/models/shuffle_format_entry'
require 'oci/data_safe/models/sort_orders'
require 'oci/data_safe/models/sql_collection'
require 'oci/data_safe/models/sql_collection_aggregation'
require 'oci/data_safe/models/sql_collection_analytics_collection'
require 'oci/data_safe/models/sql_collection_collection'
require 'oci/data_safe/models/sql_collection_dimensions'
require 'oci/data_safe/models/sql_collection_lifecycle_state'
require 'oci/data_safe/models/sql_collection_log_aggregation'
require 'oci/data_safe/models/sql_collection_log_dimensions'
require 'oci/data_safe/models/sql_collection_log_insights_collection'
require 'oci/data_safe/models/sql_collection_summary'
require 'oci/data_safe/models/sql_firewall_allowed_sql'
require 'oci/data_safe/models/sql_firewall_allowed_sql_aggregation'
require 'oci/data_safe/models/sql_firewall_allowed_sql_analytics_collection'
require 'oci/data_safe/models/sql_firewall_allowed_sql_collection'
require 'oci/data_safe/models/sql_firewall_allowed_sql_dimensions'
require 'oci/data_safe/models/sql_firewall_allowed_sql_lifecycle_state'
require 'oci/data_safe/models/sql_firewall_allowed_sql_summary'
require 'oci/data_safe/models/sql_firewall_config'
require 'oci/data_safe/models/sql_firewall_policy'
require 'oci/data_safe/models/sql_firewall_policy_aggregation'
require 'oci/data_safe/models/sql_firewall_policy_analytics_collection'
require 'oci/data_safe/models/sql_firewall_policy_collection'
require 'oci/data_safe/models/sql_firewall_policy_dimensions'
require 'oci/data_safe/models/sql_firewall_policy_lifecycle_state'
require 'oci/data_safe/models/sql_firewall_policy_summary'
require 'oci/data_safe/models/sql_firewall_violation_aggregation'
require 'oci/data_safe/models/sql_firewall_violation_aggregation_dimensions'
require 'oci/data_safe/models/sql_firewall_violation_analytics_collection'
require 'oci/data_safe/models/sql_firewall_violation_summary'
require 'oci/data_safe/models/sql_firewall_violations_collection'
require 'oci/data_safe/models/start_audit_trail_details'
require 'oci/data_safe/models/substring_format_entry'
require 'oci/data_safe/models/summary'
require 'oci/data_safe/models/table_summary'
require 'oci/data_safe/models/tables_for_discovery'
require 'oci/data_safe/models/target_alert_policy_association'
require 'oci/data_safe/models/target_alert_policy_association_collection'
require 'oci/data_safe/models/target_alert_policy_association_summary'
require 'oci/data_safe/models/target_database'
require 'oci/data_safe/models/target_database_lifecycle_state'
require 'oci/data_safe/models/target_database_summary'
require 'oci/data_safe/models/tls_config'
require 'oci/data_safe/models/truncate_table_format_entry'
require 'oci/data_safe/models/udf_format_entry'
require 'oci/data_safe/models/unset_security_assessment_baseline_details'
require 'oci/data_safe/models/unset_user_assessment_baseline_details'
require 'oci/data_safe/models/update_alert_details'
require 'oci/data_safe/models/update_alert_policy_details'
require 'oci/data_safe/models/update_alert_policy_rule_details'
require 'oci/data_safe/models/update_audit_archive_retrieval_details'
require 'oci/data_safe/models/update_audit_policy_details'
require 'oci/data_safe/models/update_audit_profile_details'
require 'oci/data_safe/models/update_audit_trail_details'
require 'oci/data_safe/models/update_column_source_details'
require 'oci/data_safe/models/update_column_source_sdm_details'
require 'oci/data_safe/models/update_column_source_target_details'
require 'oci/data_safe/models/update_data_safe_private_endpoint_details'
require 'oci/data_safe/models/update_database_security_config_details'
require 'oci/data_safe/models/update_finding_details'
require 'oci/data_safe/models/update_library_masking_format_details'
require 'oci/data_safe/models/update_masking_column_details'
require 'oci/data_safe/models/update_masking_policy_details'
require 'oci/data_safe/models/update_on_prem_connector_details'
require 'oci/data_safe/models/update_on_prem_connector_wallet_details'
require 'oci/data_safe/models/update_peer_target_database_details'
require 'oci/data_safe/models/update_report_definition_details'
require 'oci/data_safe/models/update_report_details'
require 'oci/data_safe/models/update_sdm_masking_policy_difference_details'
require 'oci/data_safe/models/update_security_assessment_details'
require 'oci/data_safe/models/update_security_policy_deployment_details'
require 'oci/data_safe/models/update_security_policy_details'
require 'oci/data_safe/models/update_sensitive_category_details'
require 'oci/data_safe/models/update_sensitive_column_details'
require 'oci/data_safe/models/update_sensitive_data_model_details'
require 'oci/data_safe/models/update_sensitive_type_details'
require 'oci/data_safe/models/update_sensitive_type_pattern_details'
require 'oci/data_safe/models/update_sql_collection_details'
require 'oci/data_safe/models/update_sql_firewall_config_details'
require 'oci/data_safe/models/update_sql_firewall_policy_details'
require 'oci/data_safe/models/update_target_alert_policy_association_details'
require 'oci/data_safe/models/update_target_database_details'
require 'oci/data_safe/models/update_user_assessment_details'
require 'oci/data_safe/models/user_access_analytics_collection'
require 'oci/data_safe/models/user_access_analytics_summary'
require 'oci/data_safe/models/user_aggregation'
require 'oci/data_safe/models/user_assessment'
require 'oci/data_safe/models/user_assessment_base_line_details'
require 'oci/data_safe/models/user_assessment_comparison'
require 'oci/data_safe/models/user_assessment_lifecycle_state'
require 'oci/data_safe/models/user_assessment_summary'
require 'oci/data_safe/models/user_details'
require 'oci/data_safe/models/user_summary'
require 'oci/data_safe/models/work_request'
require 'oci/data_safe/models/work_request_error'
require 'oci/data_safe/models/work_request_log_entry'
require 'oci/data_safe/models/work_request_resource'
require 'oci/data_safe/models/work_request_summary'

# Require generated clients
require 'oci/data_safe/data_safe_client'
require 'oci/data_safe/data_safe_client_composite_operations'

# Require service utilities
require 'oci/data_safe/util'
