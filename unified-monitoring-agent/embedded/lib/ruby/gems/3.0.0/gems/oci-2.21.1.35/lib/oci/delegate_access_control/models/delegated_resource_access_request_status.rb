# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230801

module OCI
  module DelegateAccessControl::Models
    DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_ENUM = [
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_CREATED = 'CREATED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_APPROVAL_WAITING = 'APPROVAL_WAITING'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_OPERATOR_ASSIGNMENT_WAITING = 'OPERATOR_ASSIGNMENT_WAITING'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_PREAPPROVED = 'PREAPPROVED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_APPROVED = 'APPROVED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_APPROVED_FOR_FUTURE = 'APPROVED_FOR_FUTURE'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_REJECTED = 'REJECTED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_DEPLOYED = 'DEPLOYED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_DEPLOY_FAILED = 'DEPLOY_FAILED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_UNDEPLOYED = 'UNDEPLOYED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_UNDEPLOY_FAILED = 'UNDEPLOY_FAILED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_CLOSE_FAILED = 'CLOSE_FAILED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_REVOKE_FAILED = 'REVOKE_FAILED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_EXPIRY_FAILED = 'EXPIRY_FAILED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_REVOKING = 'REVOKING'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_REVOKED = 'REVOKED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_EXTENDING = 'EXTENDING'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_EXTENDED = 'EXTENDED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_EXTENSION_REJECTED = 'EXTENSION_REJECTED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_EXTENSION_FAILED = 'EXTENSION_FAILED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_COMPLETING = 'COMPLETING'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_COMPLETED = 'COMPLETED'.freeze,
      DELEGATED_RESOURCE_ACCESS_REQUEST_STATUS_EXPIRED = 'EXPIRED'.freeze
    ].freeze
  end
end
