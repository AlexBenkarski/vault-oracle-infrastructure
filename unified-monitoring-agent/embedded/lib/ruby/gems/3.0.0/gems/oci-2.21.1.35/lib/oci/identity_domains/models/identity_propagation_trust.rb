# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: v1
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Schema used for Identity Propagation Trust.
  class IdentityDomains::Models::IdentityPropagationTrust
    IDCS_PREVENTED_OPERATIONS_ENUM = [
      IDCS_PREVENTED_OPERATIONS_REPLACE = 'replace'.freeze,
      IDCS_PREVENTED_OPERATIONS_UPDATE = 'update'.freeze,
      IDCS_PREVENTED_OPERATIONS_DELETE = 'delete'.freeze,
      IDCS_PREVENTED_OPERATIONS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    TYPE_ENUM = [
      TYPE_JWT = 'JWT'.freeze,
      TYPE_SAML = 'SAML'.freeze,
      TYPE_SPNEGO = 'SPNEGO'.freeze,
      TYPE_AWS = 'AWS'.freeze,
      TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    SUBJECT_TYPE_ENUM = [
      SUBJECT_TYPE_USER = 'User'.freeze,
      SUBJECT_TYPE_APP = 'App'.freeze,
      SUBJECT_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # Unique identifier for the SCIM Resource as defined by the Service Provider. Each representation of the Resource MUST include a non-empty id value. This identifier MUST be unique across the Service Provider's entire set of Resources. It MUST be a stable, non-reassignable identifier that does not change when the same Resource is returned in subsequent requests. The value of the id attribute is always issued by the Service Provider and MUST never be specified by the Service Consumer. bulkId: is a reserved keyword and MUST NOT be used in the unique identifier.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readOnly
    #  - required: false
    #  - returned: always
    #  - type: string
    #  - uniqueness: global
    # @return [String]
    attr_accessor :id

    # Unique OCI identifier for the SCIM Resource.
    #
    # **SCIM++ Properties:**
    #  - caseExact: true
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: immutable
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: global
    # @return [String]
    attr_accessor :ocid

    # **[Required]** REQUIRED. The schemas attribute is an array of Strings which allows introspection of the supported schema version for a SCIM representation as well any schema extensions supported by that representation. Each String value must be a unique URI. This specification defines URIs for User, Group, and a standard \\\"enterprise\\\" extension. All representations of SCIM schema MUST include a non-zero value array with value(s) of the URIs supported by that representation. Duplicate values MUST NOT be included. Value order is not specified and MUST not impact behavior.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: false
    #  - multiValued: true
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [Array<String>]
    attr_accessor :schemas

    # @return [OCI::IdentityDomains::Models::Meta]
    attr_accessor :meta

    # @return [OCI::IdentityDomains::Models::IdcsCreatedBy]
    attr_accessor :idcs_created_by

    # @return [OCI::IdentityDomains::Models::IdcsLastModifiedBy]
    attr_accessor :idcs_last_modified_by

    # Each value of this attribute specifies an operation that only an internal client may perform on this particular resource.
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: true
    #  - mutability: readOnly
    #  - required: false
    #  - returned: request
    #  - type: string
    #  - uniqueness: none
    # @return [Array<String>]
    attr_reader :idcs_prevented_operations

    # A list of tags on this resource.
    #
    # **SCIM++ Properties:**
    #  - idcsCompositeKey: [key, value]
    #  - idcsSearchable: true
    #  - multiValued: true
    #  - mutability: readWrite
    #  - required: false
    #  - returned: request
    #  - type: complex
    #  - uniqueness: none
    # @return [Array<OCI::IdentityDomains::Models::Tags>]
    attr_accessor :tags

    # A boolean flag indicating this resource in the process of being deleted. Usually set to true when synchronous deletion of the resource would take too long.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readOnly
    #  - required: false
    #  - returned: default
    #  - type: boolean
    #  - uniqueness: none
    # @return [BOOLEAN]
    attr_accessor :delete_in_progress

    # The release number when the resource was upgraded.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readOnly
    #  - required: false
    #  - returned: request
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :idcs_last_upgraded_in_release

    # OCI Domain Id (ocid) in which the resource lives.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readOnly
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :domain_ocid

    # OCI Compartment Id (ocid) in which the resource lives.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readOnly
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :compartment_ocid

    # OCI Tenant Id (ocid) in which the resource lives.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readOnly
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :tenancy_ocid

    # **[Required]** The name of the the Identity Propagation Trust.
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - caseExact: false
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - required: true
    #  - mutability: immutable
    #  - returned: default
    #  - uniqueness: none
    # @return [String]
    attr_accessor :name

    # The description of the Identity Propagation Trust.
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - multiValued: false
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - uniqueness: none
    #  - caseExact: false
    #  - idcsSearchable: false
    # @return [String]
    attr_accessor :description

    # **[Required]** The type of the inbound token from the Identity cloud provider.
    #
    # **SCIM++ Properties:**
    #  - caseExact: true
    #  - idcsSearchable: false
    #  - required: true
    #  - mutability: readWrite
    #  - returned: default
    #  - type: string
    #  - multiValued: false
    #  - uniqueness: none
    # @return [String]
    attr_reader :type

    # **[Required]** The issuer claim of the Identity provider.
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - multiValued: false
    #  - required: true
    #  - mutability: readWrite
    #  - returned: always
    #  - caseExact: true
    #  - idcsSearchable: true
    #  - uniqueness: server
    # @return [String]
    attr_accessor :issuer

    # The Identity cloud provider service identifier, for example, the Azure Tenancy ID, AWS Account ID, or GCP Project ID.
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - multiValued: false
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - caseExact: true
    #  - idcsSearchable: true
    #  - uniqueness: none
    # @return [String]
    attr_accessor :account_id

    # Used for locating the subject claim from the incoming token.
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - multiValued: false
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - uniqueness: none
    #  - caseExact: true
    #  - idcsSearchable: false
    # @return [String]
    attr_accessor :subject_claim_name

    # Subject Mapping Attribute to which the value from subject claim name value would be used for identity lookup.
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - multiValued: false
    #  - idcsSearchable: false
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - uniqueness: none
    # @return [String]
    attr_accessor :subject_mapping_attribute

    # The type of the resource against which lookup will be made in the identity domain in IAM for the incoming subject claim value.
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_reader :subject_type

    # The claim name that identifies to whom the JWT/SAML token is issued. If AWS, then \\\"aud\\\" or \\\"client_id\\\". If Azure, then \\\"appid\\\". If GCP, then \\\"aud\\\".
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - multiValued: false
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - uniqueness: none
    #  - idcsSearchable: false
    # @return [String]
    attr_accessor :client_claim_name

    # The value that corresponds to the client claim name used to identify to whom the token is issued.
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - multiValued: true
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - uniqueness: none
    #  - caseExact: true
    #  - idcsSearchable: false
    # @return [Array<String>]
    attr_accessor :client_claim_values

    # If true, specifies that this Identity Propagation Trust is in an enabled state. The default value is false.
    #
    # **SCIM++ Properties:**
    #  - type: boolean
    #  - multiValued: false
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - uniqueness: none
    #  - idcsSearchable: true
    # @return [BOOLEAN]
    attr_accessor :active

    # The cloud provider's public key API of SAML and OIDC providers for signature validation.
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - multiValued: false
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - uniqueness: none
    #  - caseExact: false
    #  - idcsSearchable: false
    # @return [String]
    attr_accessor :public_key_endpoint

    # Store the public key if public key cert.
    #
    # **SCIM++ Properties:**
    #  - type: string
    #  - multiValued: false
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - uniqueness: none
    #  - idcsSearchable: false
    # @return [String]
    attr_accessor :public_certificate

    # The value of all the authorized OAuth Clients.
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: true
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [Array<String>]
    attr_accessor :oauth_clients

    # Allow customers to define whether the resulting token should contain the authenticated user as the subject or whether the token should impersonate another Application Principal in IAM.
    #
    # **SCIM++ Properties:**
    #  - type: boolean
    #  - multiValued: false
    #  - required: false
    #  - mutability: readWrite
    #  - returned: default
    #  - uniqueness: none
    #  - idcsSearchable: false
    # @return [BOOLEAN]
    attr_accessor :allow_impersonation

    # The clock skew (in secs) that's allowed for the token issue and expiry time.
    #
    # **Added In:** 2308181911
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :clock_skew_seconds

    # The Impersonating Principal.
    #
    # **SCIM++ Properties:**
    #  - idcsCompositeKey: [rule, value]
    #  - idcsSearchable: false
    #  - multiValued: true
    #  - mutability: readWrite
    #  - required: false
    #  - returned: request
    #  - type: complex
    #  - uniqueness: none
    # @return [Array<OCI::IdentityDomains::Models::IdentityPropagationTrustImpersonationServiceUsers>]
    attr_accessor :impersonation_service_users

    # @return [OCI::IdentityDomains::Models::IdentityPropagationTrustKeytab]
    attr_accessor :keytab

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'ocid': :'ocid',
        'schemas': :'schemas',
        'meta': :'meta',
        'idcs_created_by': :'idcsCreatedBy',
        'idcs_last_modified_by': :'idcsLastModifiedBy',
        'idcs_prevented_operations': :'idcsPreventedOperations',
        'tags': :'tags',
        'delete_in_progress': :'deleteInProgress',
        'idcs_last_upgraded_in_release': :'idcsLastUpgradedInRelease',
        'domain_ocid': :'domainOcid',
        'compartment_ocid': :'compartmentOcid',
        'tenancy_ocid': :'tenancyOcid',
        'name': :'name',
        'description': :'description',
        'type': :'type',
        'issuer': :'issuer',
        'account_id': :'accountId',
        'subject_claim_name': :'subjectClaimName',
        'subject_mapping_attribute': :'subjectMappingAttribute',
        'subject_type': :'subjectType',
        'client_claim_name': :'clientClaimName',
        'client_claim_values': :'clientClaimValues',
        'active': :'active',
        'public_key_endpoint': :'publicKeyEndpoint',
        'public_certificate': :'publicCertificate',
        'oauth_clients': :'oauthClients',
        'allow_impersonation': :'allowImpersonation',
        'clock_skew_seconds': :'clockSkewSeconds',
        'impersonation_service_users': :'impersonationServiceUsers',
        'keytab': :'keytab'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'ocid': :'String',
        'schemas': :'Array<String>',
        'meta': :'OCI::IdentityDomains::Models::Meta',
        'idcs_created_by': :'OCI::IdentityDomains::Models::IdcsCreatedBy',
        'idcs_last_modified_by': :'OCI::IdentityDomains::Models::IdcsLastModifiedBy',
        'idcs_prevented_operations': :'Array<String>',
        'tags': :'Array<OCI::IdentityDomains::Models::Tags>',
        'delete_in_progress': :'BOOLEAN',
        'idcs_last_upgraded_in_release': :'String',
        'domain_ocid': :'String',
        'compartment_ocid': :'String',
        'tenancy_ocid': :'String',
        'name': :'String',
        'description': :'String',
        'type': :'String',
        'issuer': :'String',
        'account_id': :'String',
        'subject_claim_name': :'String',
        'subject_mapping_attribute': :'String',
        'subject_type': :'String',
        'client_claim_name': :'String',
        'client_claim_values': :'Array<String>',
        'active': :'BOOLEAN',
        'public_key_endpoint': :'String',
        'public_certificate': :'String',
        'oauth_clients': :'Array<String>',
        'allow_impersonation': :'BOOLEAN',
        'clock_skew_seconds': :'Integer',
        'impersonation_service_users': :'Array<OCI::IdentityDomains::Models::IdentityPropagationTrustImpersonationServiceUsers>',
        'keytab': :'OCI::IdentityDomains::Models::IdentityPropagationTrustKeytab'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :ocid The value to assign to the {#ocid} property
    # @option attributes [Array<String>] :schemas The value to assign to the {#schemas} property
    # @option attributes [OCI::IdentityDomains::Models::Meta] :meta The value to assign to the {#meta} property
    # @option attributes [OCI::IdentityDomains::Models::IdcsCreatedBy] :idcs_created_by The value to assign to the {#idcs_created_by} property
    # @option attributes [OCI::IdentityDomains::Models::IdcsLastModifiedBy] :idcs_last_modified_by The value to assign to the {#idcs_last_modified_by} property
    # @option attributes [Array<String>] :idcs_prevented_operations The value to assign to the {#idcs_prevented_operations} property
    # @option attributes [Array<OCI::IdentityDomains::Models::Tags>] :tags The value to assign to the {#tags} property
    # @option attributes [BOOLEAN] :delete_in_progress The value to assign to the {#delete_in_progress} property
    # @option attributes [String] :idcs_last_upgraded_in_release The value to assign to the {#idcs_last_upgraded_in_release} property
    # @option attributes [String] :domain_ocid The value to assign to the {#domain_ocid} property
    # @option attributes [String] :compartment_ocid The value to assign to the {#compartment_ocid} property
    # @option attributes [String] :tenancy_ocid The value to assign to the {#tenancy_ocid} property
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :type The value to assign to the {#type} property
    # @option attributes [String] :issuer The value to assign to the {#issuer} property
    # @option attributes [String] :account_id The value to assign to the {#account_id} property
    # @option attributes [String] :subject_claim_name The value to assign to the {#subject_claim_name} property
    # @option attributes [String] :subject_mapping_attribute The value to assign to the {#subject_mapping_attribute} property
    # @option attributes [String] :subject_type The value to assign to the {#subject_type} property
    # @option attributes [String] :client_claim_name The value to assign to the {#client_claim_name} property
    # @option attributes [Array<String>] :client_claim_values The value to assign to the {#client_claim_values} property
    # @option attributes [BOOLEAN] :active The value to assign to the {#active} property
    # @option attributes [String] :public_key_endpoint The value to assign to the {#public_key_endpoint} property
    # @option attributes [String] :public_certificate The value to assign to the {#public_certificate} property
    # @option attributes [Array<String>] :oauth_clients The value to assign to the {#oauth_clients} property
    # @option attributes [BOOLEAN] :allow_impersonation The value to assign to the {#allow_impersonation} property
    # @option attributes [Integer] :clock_skew_seconds The value to assign to the {#clock_skew_seconds} property
    # @option attributes [Array<OCI::IdentityDomains::Models::IdentityPropagationTrustImpersonationServiceUsers>] :impersonation_service_users The value to assign to the {#impersonation_service_users} property
    # @option attributes [OCI::IdentityDomains::Models::IdentityPropagationTrustKeytab] :keytab The value to assign to the {#keytab} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.ocid = attributes[:'ocid'] if attributes[:'ocid']

      self.schemas = attributes[:'schemas'] if attributes[:'schemas']

      self.meta = attributes[:'meta'] if attributes[:'meta']

      self.idcs_created_by = attributes[:'idcsCreatedBy'] if attributes[:'idcsCreatedBy']

      raise 'You cannot provide both :idcsCreatedBy and :idcs_created_by' if attributes.key?(:'idcsCreatedBy') && attributes.key?(:'idcs_created_by')

      self.idcs_created_by = attributes[:'idcs_created_by'] if attributes[:'idcs_created_by']

      self.idcs_last_modified_by = attributes[:'idcsLastModifiedBy'] if attributes[:'idcsLastModifiedBy']

      raise 'You cannot provide both :idcsLastModifiedBy and :idcs_last_modified_by' if attributes.key?(:'idcsLastModifiedBy') && attributes.key?(:'idcs_last_modified_by')

      self.idcs_last_modified_by = attributes[:'idcs_last_modified_by'] if attributes[:'idcs_last_modified_by']

      self.idcs_prevented_operations = attributes[:'idcsPreventedOperations'] if attributes[:'idcsPreventedOperations']

      raise 'You cannot provide both :idcsPreventedOperations and :idcs_prevented_operations' if attributes.key?(:'idcsPreventedOperations') && attributes.key?(:'idcs_prevented_operations')

      self.idcs_prevented_operations = attributes[:'idcs_prevented_operations'] if attributes[:'idcs_prevented_operations']

      self.tags = attributes[:'tags'] if attributes[:'tags']

      self.delete_in_progress = attributes[:'deleteInProgress'] unless attributes[:'deleteInProgress'].nil?

      raise 'You cannot provide both :deleteInProgress and :delete_in_progress' if attributes.key?(:'deleteInProgress') && attributes.key?(:'delete_in_progress')

      self.delete_in_progress = attributes[:'delete_in_progress'] unless attributes[:'delete_in_progress'].nil?

      self.idcs_last_upgraded_in_release = attributes[:'idcsLastUpgradedInRelease'] if attributes[:'idcsLastUpgradedInRelease']

      raise 'You cannot provide both :idcsLastUpgradedInRelease and :idcs_last_upgraded_in_release' if attributes.key?(:'idcsLastUpgradedInRelease') && attributes.key?(:'idcs_last_upgraded_in_release')

      self.idcs_last_upgraded_in_release = attributes[:'idcs_last_upgraded_in_release'] if attributes[:'idcs_last_upgraded_in_release']

      self.domain_ocid = attributes[:'domainOcid'] if attributes[:'domainOcid']

      raise 'You cannot provide both :domainOcid and :domain_ocid' if attributes.key?(:'domainOcid') && attributes.key?(:'domain_ocid')

      self.domain_ocid = attributes[:'domain_ocid'] if attributes[:'domain_ocid']

      self.compartment_ocid = attributes[:'compartmentOcid'] if attributes[:'compartmentOcid']

      raise 'You cannot provide both :compartmentOcid and :compartment_ocid' if attributes.key?(:'compartmentOcid') && attributes.key?(:'compartment_ocid')

      self.compartment_ocid = attributes[:'compartment_ocid'] if attributes[:'compartment_ocid']

      self.tenancy_ocid = attributes[:'tenancyOcid'] if attributes[:'tenancyOcid']

      raise 'You cannot provide both :tenancyOcid and :tenancy_ocid' if attributes.key?(:'tenancyOcid') && attributes.key?(:'tenancy_ocid')

      self.tenancy_ocid = attributes[:'tenancy_ocid'] if attributes[:'tenancy_ocid']

      self.name = attributes[:'name'] if attributes[:'name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.type = attributes[:'type'] if attributes[:'type']

      self.issuer = attributes[:'issuer'] if attributes[:'issuer']

      self.account_id = attributes[:'accountId'] if attributes[:'accountId']

      raise 'You cannot provide both :accountId and :account_id' if attributes.key?(:'accountId') && attributes.key?(:'account_id')

      self.account_id = attributes[:'account_id'] if attributes[:'account_id']

      self.subject_claim_name = attributes[:'subjectClaimName'] if attributes[:'subjectClaimName']

      raise 'You cannot provide both :subjectClaimName and :subject_claim_name' if attributes.key?(:'subjectClaimName') && attributes.key?(:'subject_claim_name')

      self.subject_claim_name = attributes[:'subject_claim_name'] if attributes[:'subject_claim_name']

      self.subject_mapping_attribute = attributes[:'subjectMappingAttribute'] if attributes[:'subjectMappingAttribute']

      raise 'You cannot provide both :subjectMappingAttribute and :subject_mapping_attribute' if attributes.key?(:'subjectMappingAttribute') && attributes.key?(:'subject_mapping_attribute')

      self.subject_mapping_attribute = attributes[:'subject_mapping_attribute'] if attributes[:'subject_mapping_attribute']

      self.subject_type = attributes[:'subjectType'] if attributes[:'subjectType']

      raise 'You cannot provide both :subjectType and :subject_type' if attributes.key?(:'subjectType') && attributes.key?(:'subject_type')

      self.subject_type = attributes[:'subject_type'] if attributes[:'subject_type']

      self.client_claim_name = attributes[:'clientClaimName'] if attributes[:'clientClaimName']

      raise 'You cannot provide both :clientClaimName and :client_claim_name' if attributes.key?(:'clientClaimName') && attributes.key?(:'client_claim_name')

      self.client_claim_name = attributes[:'client_claim_name'] if attributes[:'client_claim_name']

      self.client_claim_values = attributes[:'clientClaimValues'] if attributes[:'clientClaimValues']

      raise 'You cannot provide both :clientClaimValues and :client_claim_values' if attributes.key?(:'clientClaimValues') && attributes.key?(:'client_claim_values')

      self.client_claim_values = attributes[:'client_claim_values'] if attributes[:'client_claim_values']

      self.active = attributes[:'active'] unless attributes[:'active'].nil?

      self.public_key_endpoint = attributes[:'publicKeyEndpoint'] if attributes[:'publicKeyEndpoint']

      raise 'You cannot provide both :publicKeyEndpoint and :public_key_endpoint' if attributes.key?(:'publicKeyEndpoint') && attributes.key?(:'public_key_endpoint')

      self.public_key_endpoint = attributes[:'public_key_endpoint'] if attributes[:'public_key_endpoint']

      self.public_certificate = attributes[:'publicCertificate'] if attributes[:'publicCertificate']

      raise 'You cannot provide both :publicCertificate and :public_certificate' if attributes.key?(:'publicCertificate') && attributes.key?(:'public_certificate')

      self.public_certificate = attributes[:'public_certificate'] if attributes[:'public_certificate']

      self.oauth_clients = attributes[:'oauthClients'] if attributes[:'oauthClients']

      raise 'You cannot provide both :oauthClients and :oauth_clients' if attributes.key?(:'oauthClients') && attributes.key?(:'oauth_clients')

      self.oauth_clients = attributes[:'oauth_clients'] if attributes[:'oauth_clients']

      self.allow_impersonation = attributes[:'allowImpersonation'] unless attributes[:'allowImpersonation'].nil?

      raise 'You cannot provide both :allowImpersonation and :allow_impersonation' if attributes.key?(:'allowImpersonation') && attributes.key?(:'allow_impersonation')

      self.allow_impersonation = attributes[:'allow_impersonation'] unless attributes[:'allow_impersonation'].nil?

      self.clock_skew_seconds = attributes[:'clockSkewSeconds'] if attributes[:'clockSkewSeconds']

      raise 'You cannot provide both :clockSkewSeconds and :clock_skew_seconds' if attributes.key?(:'clockSkewSeconds') && attributes.key?(:'clock_skew_seconds')

      self.clock_skew_seconds = attributes[:'clock_skew_seconds'] if attributes[:'clock_skew_seconds']

      self.impersonation_service_users = attributes[:'impersonationServiceUsers'] if attributes[:'impersonationServiceUsers']

      raise 'You cannot provide both :impersonationServiceUsers and :impersonation_service_users' if attributes.key?(:'impersonationServiceUsers') && attributes.key?(:'impersonation_service_users')

      self.impersonation_service_users = attributes[:'impersonation_service_users'] if attributes[:'impersonation_service_users']

      self.keytab = attributes[:'keytab'] if attributes[:'keytab']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] idcs_prevented_operations Object to be assigned
    def idcs_prevented_operations=(idcs_prevented_operations)
      # rubocop:disable Style/ConditionalAssignment
      if idcs_prevented_operations.nil?
        @idcs_prevented_operations = nil
      else
        @idcs_prevented_operations =
          idcs_prevented_operations.collect do |item|
            if IDCS_PREVENTED_OPERATIONS_ENUM.include?(item)
              item
            else
              OCI.logger.debug("Unknown value for 'idcs_prevented_operations' [#{item}]. Mapping to 'IDCS_PREVENTED_OPERATIONS_UNKNOWN_ENUM_VALUE'") if OCI.logger
              IDCS_PREVENTED_OPERATIONS_UNKNOWN_ENUM_VALUE
            end
          end
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] type Object to be assigned
    def type=(type)
      # rubocop:disable Style/ConditionalAssignment
      if type && !TYPE_ENUM.include?(type)
        OCI.logger.debug("Unknown value for 'type' [" + type + "]. Mapping to 'TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @type = TYPE_UNKNOWN_ENUM_VALUE
      else
        @type = type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] subject_type Object to be assigned
    def subject_type=(subject_type)
      # rubocop:disable Style/ConditionalAssignment
      if subject_type && !SUBJECT_TYPE_ENUM.include?(subject_type)
        OCI.logger.debug("Unknown value for 'subject_type' [" + subject_type + "]. Mapping to 'SUBJECT_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @subject_type = SUBJECT_TYPE_UNKNOWN_ENUM_VALUE
      else
        @subject_type = subject_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        id == other.id &&
        ocid == other.ocid &&
        schemas == other.schemas &&
        meta == other.meta &&
        idcs_created_by == other.idcs_created_by &&
        idcs_last_modified_by == other.idcs_last_modified_by &&
        idcs_prevented_operations == other.idcs_prevented_operations &&
        tags == other.tags &&
        delete_in_progress == other.delete_in_progress &&
        idcs_last_upgraded_in_release == other.idcs_last_upgraded_in_release &&
        domain_ocid == other.domain_ocid &&
        compartment_ocid == other.compartment_ocid &&
        tenancy_ocid == other.tenancy_ocid &&
        name == other.name &&
        description == other.description &&
        type == other.type &&
        issuer == other.issuer &&
        account_id == other.account_id &&
        subject_claim_name == other.subject_claim_name &&
        subject_mapping_attribute == other.subject_mapping_attribute &&
        subject_type == other.subject_type &&
        client_claim_name == other.client_claim_name &&
        client_claim_values == other.client_claim_values &&
        active == other.active &&
        public_key_endpoint == other.public_key_endpoint &&
        public_certificate == other.public_certificate &&
        oauth_clients == other.oauth_clients &&
        allow_impersonation == other.allow_impersonation &&
        clock_skew_seconds == other.clock_skew_seconds &&
        impersonation_service_users == other.impersonation_service_users &&
        keytab == other.keytab
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines

    # @see the `==` method
    # @param [Object] other the other object to be compared
    def eql?(other)
      self == other
    end

    # rubocop:disable Metrics/AbcSize, Layout/EmptyLines


    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [id, ocid, schemas, meta, idcs_created_by, idcs_last_modified_by, idcs_prevented_operations, tags, delete_in_progress, idcs_last_upgraded_in_release, domain_ocid, compartment_ocid, tenancy_ocid, name, description, type, issuer, account_id, subject_claim_name, subject_mapping_attribute, subject_type, client_claim_name, client_claim_values, active, public_key_endpoint, public_certificate, oauth_clients, allow_impersonation, clock_skew_seconds, impersonation_service_users, keytab].hash
    end
    # rubocop:enable Metrics/AbcSize, Layout/EmptyLines

    # rubocop:disable Metrics/AbcSize, Layout/EmptyLines


    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)

      self.class.swagger_types.each_pair do |key, type|
        if type =~ /^Array<(.*)>/i
          # check to ensure the input is an array given that the the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            public_method("#{key}=").call(
              attributes[self.class.attribute_map[key]]
                .map { |v| OCI::Internal::Util.convert_to_type(Regexp.last_match(1), v) }
            )
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          public_method("#{key}=").call(
            OCI::Internal::Util.convert_to_type(type, attributes[self.class.attribute_map[key]])
          )
        end
        # or else data not found in attributes(hash), not an issue as the data can be optional
      end

      self
    end
    # rubocop:enable Metrics/AbcSize, Layout/EmptyLines

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = public_method(attr).call
        next if value.nil? && !instance_variable_defined?("@#{attr}")

        hash[param] = _to_hash(value)
      end
      hash
    end

    private

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end
  end
end
# rubocop:enable Lint/UnneededCopDisableDirective, Metrics/LineLength
