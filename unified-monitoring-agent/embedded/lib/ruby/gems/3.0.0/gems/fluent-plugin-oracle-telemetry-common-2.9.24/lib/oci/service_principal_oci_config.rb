require 'oci/config'
class ServicePrincipalOciConfig < OCI::Config
  # override the validate for the config since the hydra pika frontend client doesn't have service/resource principals
  # as an accepted signer, even though the call works with it. Swagger changes need to be made in the SDK/bmc-sdk-swagger
  # repo to accomodate the client changes in the future
  def validate
    true
  end
end