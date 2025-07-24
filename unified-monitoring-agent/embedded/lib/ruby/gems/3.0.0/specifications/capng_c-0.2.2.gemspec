# -*- encoding: utf-8 -*-
# stub: capng_c 0.2.2 ruby lib
# stub: ext/capng/extconf.rb

Gem::Specification.new do |s|
  s.name = "capng_c".freeze
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "homepage_uri" => "https://github.com/fluent-plugins-nursery/capng_c", "source_code_uri" => "https://github.com/fluent-plugins-nursery/capng_c" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Hiroshi Hatake".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-12-25"
  s.description = "libcap-ng bindings for Ruby.".freeze
  s.email = ["cosmo0920.wp@gmail.com".freeze]
  s.extensions = ["ext/capng/extconf.rb".freeze]
  s.files = ["ext/capng/extconf.rb".freeze]
  s.homepage = "https://github.com/fluent-plugins-nursery/capng_c".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.2.33".freeze
  s.summary = "libcap-ng bindings for Ruby.".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.16", "< 3"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rake-compiler>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.3.3"])
    s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 1.16", "< 3"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rake-compiler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 3.3.3"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
  end
end
