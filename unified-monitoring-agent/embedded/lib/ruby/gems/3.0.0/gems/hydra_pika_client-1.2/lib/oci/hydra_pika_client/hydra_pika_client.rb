# Copyright (c) 2016, 2022, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

module OCI
  module HydraPikaClient
    # Module containing models for requests made to, and responses received from,
    # OCI HydraPikaClient services
    module Models
    end
  end
end

# Require models
require 'oci/hydra_pika_client/models/add_log_stream_definition_request_body'
require 'oci/hydra_pika_client/models/add_log_stream_definition_response_body'
require 'oci/hydra_pika_client/models/add_logs_request_body'
require 'oci/hydra_pika_client/models/get_log_stream_definition_response_body'
require 'oci/hydra_pika_client/models/log_entry'
require 'oci/hydra_pika_client/models/log_stream_definition'
require 'oci/hydra_pika_client/models/request_error'

# Require generated clients
require 'oci/hydra_pika_client/hydra_pika_frontend_client'

# Require service utilities
require 'oci/hydra_pika_client/util'
