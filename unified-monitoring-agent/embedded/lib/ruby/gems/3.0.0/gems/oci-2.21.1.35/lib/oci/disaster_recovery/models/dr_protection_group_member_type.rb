# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220125

module OCI
  module DisasterRecovery::Models
    DR_PROTECTION_GROUP_MEMBER_TYPE_ENUM = [
      DR_PROTECTION_GROUP_MEMBER_TYPE_COMPUTE_INSTANCE = 'COMPUTE_INSTANCE'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_COMPUTE_INSTANCE_MOVABLE = 'COMPUTE_INSTANCE_MOVABLE'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_COMPUTE_INSTANCE_NON_MOVABLE = 'COMPUTE_INSTANCE_NON_MOVABLE'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_VOLUME_GROUP = 'VOLUME_GROUP'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_DATABASE = 'DATABASE'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_AUTONOMOUS_DATABASE = 'AUTONOMOUS_DATABASE'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_AUTONOMOUS_CONTAINER_DATABASE = 'AUTONOMOUS_CONTAINER_DATABASE'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_LOAD_BALANCER = 'LOAD_BALANCER'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_NETWORK_LOAD_BALANCER = 'NETWORK_LOAD_BALANCER'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_FILE_SYSTEM = 'FILE_SYSTEM'.freeze,
      DR_PROTECTION_GROUP_MEMBER_TYPE_OBJECT_STORAGE_BUCKET = 'OBJECT_STORAGE_BUCKET'.freeze
    ].freeze
  end
end
