# Copyright (c) 2023,2024, Oracle and/or its affiliates.
# Extend the service account token provider

require 'jwt'
require 'rest-client'
require 'ostruct'

module OCI
  module Auth
    module Signers
      # Service Account Token Provider
      # Classes under this module will provide the service account token required for OKE auth provider
      module ServiceAccountTokenProvider

        # Class that takes a namespace and service account from the user
        class SuppliedServiceAccountProvider

          def initialize(namespace, service_account_name)
            @ns = namespace
            @sa = service_account_name
          end

          def service_account_token
            sa_token = get_service_account_token(@ns, @sa)
            is_sa_token_valid = OCI::Auth::Signers::ServiceAccountTokenProvider.valid_sa_token?(sa_token)
            raise 'The supplied service account token has expired.' if is_sa_token_valid == false

            sa_token
          end

          ##
          def get_service_account_token(ns, sa)

            if ns == nil
              raise StandardError.new("namespace not provided for workload resource type")
            end

            # We need to create the token
            service_host = ENV[KUBERNETES_SERVICE_HOST]
            url = "https://#{service_host}/api/v1/namespaces/#{ns}/serviceaccounts/#{sa}/token"

            # Use our own service account for query
            access_token = File.read('/var/run/secrets/kubernetes.io/serviceaccount/token')
            resp = RestClient::Request.execute(
                   url: url,
                   method: :post,
                   verify_ssl: true,
                   ssl_ca_file: "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt",
                   headers: {:Authorization => "Bearer %s" % [access_token], :Content_Type => "application/json"},
                   payload: {}.to_json)

            # The token is in the json body response (convert to ruby object)
            object = JSON.parse(resp.body, object_class: OpenStruct)

            # Return the token
            object.status.token
          end
        end
      end

      def self.oke_workload_resource_principal_signer_with_provider(service_account_token_path: nil, service_account_token_provider: nil)

        sa_cert_path = DEFAULT_OCI_KUBERNETES_SERVICE_ACCOUNT_CERT_PATH if sa_cert_path.nil?

        if service_account_token_provider.nil?
          raise Exception("service_account_token_provider is not defined")
        else
          sa_token_provider = service_account_token_provider
        end

        service_host = ENV[KUBERNETES_SERVICE_HOST]
        region = ENV[OCI_RESOURCE_PRINCIPAL_REGION]

        OCI::Auth::Signers::OkeWorkloadIdentityResourcePrincipalSigner.new(
          sa_token_provider,
          sa_cert_path,
          service_host,
          OCI_KUBERNETES_PROXYMUX_SERVICE_PORT,
          region: region
        )
      end

    end
  end
end
