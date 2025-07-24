# -*- encoding: utf-8 -*-
# stub: fluent-plugin-oracle-telemetry-grok-parser 2.9.24 ruby lib

Gem::Specification.new do |s|
  s.name = "fluent-plugin-oracle-telemetry-grok-parser".freeze
  s.version = "2.9.24"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["SIEM".freeze]
  s.date = "2025-06-16"
  s.description = "grok parser".freeze
  s.rubygems_version = "3.2.33".freeze
  s.summary = "grok parser".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<fluentd>.freeze, ["= 1.16.5"])
    s.add_runtime_dependency(%q<hashdiff>.freeze, ["= 1.0.1"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 3.0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<fluentd>.freeze, ["= 1.16.5"])
    s.add_dependency(%q<hashdiff>.freeze, ["= 1.0.1"])
  end
end
