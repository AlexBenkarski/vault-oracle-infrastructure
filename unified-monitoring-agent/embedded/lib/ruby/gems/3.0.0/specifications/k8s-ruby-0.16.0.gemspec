# -*- encoding: utf-8 -*-
# stub: k8s-ruby 0.16.0 ruby lib

Gem::Specification.new do |s|
  s.name = "k8s-ruby".freeze
  s.version = "0.16.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["rdx.net".freeze, "Kontena, Inc.".freeze]
  s.date = "2024-02-01"
  s.email = ["firstname.lastname@rdx.net".freeze]
  s.homepage = "https://github.com/k8s-ruby/k8s-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new([">= 2.4".freeze, "< 3.4".freeze])
  s.rubygems_version = "3.2.33".freeze
  s.summary = "Kubernetes client library for Ruby".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<excon>.freeze, ["~> 0.71"])
    s.add_runtime_dependency(%q<dry-struct>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<dry-types>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<dry-configurable>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<recursive-open-struct>.freeze, ["~> 1.1.3"])
    s.add_runtime_dependency(%q<hashdiff>.freeze, ["~> 1.0.0"])
    s.add_runtime_dependency(%q<jsonpath>.freeze, ["~> 1.1"])
    s.add_runtime_dependency(%q<yajl-ruby>.freeze, ["~> 1.4.0"])
    s.add_runtime_dependency(%q<yaml-safe_load_stream3>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.17", "< 3.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 12.3.3"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 3.6.2"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.82"])
    s.add_development_dependency(%q<byebug>.freeze, ["~> 11.1"])
  else
    s.add_dependency(%q<excon>.freeze, ["~> 0.71"])
    s.add_dependency(%q<dry-struct>.freeze, [">= 0"])
    s.add_dependency(%q<dry-types>.freeze, [">= 0"])
    s.add_dependency(%q<dry-configurable>.freeze, [">= 0"])
    s.add_dependency(%q<recursive-open-struct>.freeze, ["~> 1.1.3"])
    s.add_dependency(%q<hashdiff>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<jsonpath>.freeze, ["~> 1.1"])
    s.add_dependency(%q<yajl-ruby>.freeze, ["~> 1.4.0"])
    s.add_dependency(%q<yaml-safe_load_stream3>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.17", "< 3.0"])
    s.add_dependency(%q<rake>.freeze, [">= 12.3.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
    s.add_dependency(%q<webmock>.freeze, ["~> 3.6.2"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.82"])
    s.add_dependency(%q<byebug>.freeze, ["~> 11.1"])
  end
end
