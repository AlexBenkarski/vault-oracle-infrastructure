# -*- encoding: utf-8 -*-
# stub: oci 2.21.1.35 ruby lib

Gem::Specification.new do |s|
  s.name = "oci".freeze
  s.version = "2.21.1.35"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Oracle".freeze]
  s.date = "2024-09-13"
  s.description = "Ruby SDK for Oracle Cloud Infrastructure.\nAre you a Developer using the OCI SDK? If so, please fill out our survey to help us make the OCI SDK better for you. \nhttps://oracle.questionpro.com/t/APeMlZka26?custom3=rubygems\n".freeze
  s.email = ["joe.levy@oracle.com".freeze]
  s.homepage = "https://docs.cloud.oracle.com/tools/ruby/latest/frames.html".freeze
  s.licenses = ["UPL-1.0".freeze, "Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "3.2.33".freeze
  s.summary = "Oracle Cloud Infrastructure Ruby SDK".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<json>.freeze, [">= 1.4.6", "< 3.0.0"])
    s.add_runtime_dependency(%q<inifile>.freeze, ["~> 3.0", ">= 3.0.0"])
    s.add_runtime_dependency(%q<jwt>.freeze, ["~> 2.1"])
    s.add_runtime_dependency(%q<psych>.freeze, ["~> 5.0", ">= 5.0.1"])
    s.add_runtime_dependency(%q<event_stream_parser>.freeze, ["~> 1.0.0"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 3.5", ">= 3.5.1"])
    s.add_development_dependency(%q<vcr>.freeze, ["~> 4.0"])
    s.add_development_dependency(%q<yard>.freeze, ["~> 0.9.36"])
    s.add_development_dependency(%q<os>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0.55", "<= 0.67.1"])
    s.add_development_dependency(%q<mocha>.freeze, ["~> 1.7"])
    s.add_development_dependency(%q<nokogiri>.freeze, ["~> 1.9"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.8"])
    s.add_development_dependency(%q<activesupport>.freeze, ["~> 5.2.2"])
    s.add_development_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.3.0"])
  else
    s.add_dependency(%q<json>.freeze, [">= 1.4.6", "< 3.0.0"])
    s.add_dependency(%q<inifile>.freeze, ["~> 3.0", ">= 3.0.0"])
    s.add_dependency(%q<jwt>.freeze, ["~> 2.1"])
    s.add_dependency(%q<psych>.freeze, ["~> 5.0", ">= 5.0.1"])
    s.add_dependency(%q<event_stream_parser>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 3.5", ">= 3.5.1"])
    s.add_dependency(%q<vcr>.freeze, ["~> 4.0"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9.36"])
    s.add_dependency(%q<os>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0.55", "<= 0.67.1"])
    s.add_dependency(%q<mocha>.freeze, ["~> 1.7"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.9"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
    s.add_dependency(%q<activesupport>.freeze, ["~> 5.2.2"])
    s.add_dependency(%q<rspec_junit_formatter>.freeze, ["~> 0.3.0"])
  end
end
