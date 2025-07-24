# -*- encoding: utf-8 -*-
# stub: fluent-plugin-oracle-netflowipfix 2.9.24 ruby lib

Gem::Specification.new do |s|
  s.name = "fluent-plugin-oracle-netflowipfix".freeze
  s.version = "2.9.24"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Universal Agent team".freeze]
  s.date = "2025-06-16"
  s.description = "Oracle Telemetry FluentD Plugins : ipfix parser".freeze
  s.email = ["oci-siem-agent_us_grp@oracle.com".freeze]
  s.homepage = "https://confluence.oci.oraclecorp.com/display/GRIF/Griffin+%28SIEM%29+Home".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.2.33".freeze
  s.summary = "OCI Fluentd ipfix parser".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.0"])
    s.add_runtime_dependency(%q<bindata>.freeze, ["= 2.4.10"])
    s.add_runtime_dependency(%q<fluentd>.freeze, ["= 1.16.5"])
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 3.0"])
    s.add_dependency(%q<bindata>.freeze, ["= 2.4.10"])
    s.add_dependency(%q<fluentd>.freeze, ["= 1.16.5"])
  end
end
