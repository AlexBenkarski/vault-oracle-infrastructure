# -*- encoding: utf-8 -*-
# stub: fluent-plugin-oracle-telemetry-in-agent-metrics 2.9.24 ruby lib

Gem::Specification.new do |s|
  s.name = "fluent-plugin-oracle-telemetry-in-agent-metrics".freeze
  s.version = "2.9.24"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "build_date" => "2025-06-16 08:47:23 UTC", "commit_hash" => "not-available" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Unified Agent team".freeze]
  s.date = "2025-06-16"
  s.description = "Oracle Telemetry FluentD Plugins : agent own metrics plugin".freeze
  s.email = ["oci-siem-agent_us_grp@oracle.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "https://confluence.oci.oraclecorp.com/display/GRIF/Griffin+%28SIEM%29+Home".freeze
  s.licenses = ["UPL-1.0".freeze, "Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new("~> 3.0".freeze)
  s.rubygems_version = "3.2.33".freeze
  s.summary = "OCI Fluentd agent own metrics plugin".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<fluentd>.freeze, ["= 1.16.5"])
    s.add_runtime_dependency(%q<hashdiff>.freeze, ["= 1.0.1"])
    s.add_runtime_dependency(%q<oci>.freeze, ["= 2.21.1.35"])
    s.add_development_dependency(%q<bundler>.freeze, ["= 2.2.33"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.1"])
    s.add_development_dependency(%q<rubocop-rake>.freeze, ["~> 0.6"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.22"])
    s.add_development_dependency(%q<simplecov-html>.freeze, ["~> 0.13"])
    s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.6"])
    s.add_development_dependency(%q<mocha>.freeze, ["~> 1.16"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 3.18"])
    s.add_development_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.6"])
    s.add_development_dependency(%q<test-unit-rr>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 4.7"])
    s.add_development_dependency(%q<vcr>.freeze, ["~> 6.2"])
    s.add_development_dependency(%q<rubyzip>.freeze, ["~> 2.3"])
  else
    s.add_dependency(%q<fluentd>.freeze, ["= 1.16.5"])
    s.add_dependency(%q<hashdiff>.freeze, ["= 1.0.1"])
    s.add_dependency(%q<oci>.freeze, ["= 2.21.1.35"])
    s.add_dependency(%q<bundler>.freeze, ["= 2.2.33"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.1"])
    s.add_dependency(%q<rubocop-rake>.freeze, ["~> 0.6"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.22"])
    s.add_dependency(%q<simplecov-html>.freeze, ["~> 0.13"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 3.6"])
    s.add_dependency(%q<mocha>.freeze, ["~> 1.16"])
    s.add_dependency(%q<webmock>.freeze, ["~> 3.18"])
    s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.6"])
    s.add_dependency(%q<test-unit-rr>.freeze, ["~> 1.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 4.7"])
    s.add_dependency(%q<vcr>.freeze, ["~> 6.2"])
    s.add_dependency(%q<rubyzip>.freeze, ["~> 2.3"])
  end
end
