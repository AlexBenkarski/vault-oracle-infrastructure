# -*- encoding: utf-8 -*-
# stub: yaml-safe_load_stream3 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "yaml-safe_load_stream3".freeze
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kimmo Lehto".freeze, "Levi Aul".freeze, "InSpec Team".freeze]
  s.date = "2023-04-11"
  s.description = "The Ruby standard library defines YAML.safe_load and YAML.load_stream but there's no way to safely load a multi document stream. This Gem adds YAML.safe_load_stream.".freeze
  s.email = ["info@kontena.io".freeze, "levi@leviaul.com".freeze, "inspec@progress.com".freeze]
  s.homepage = "https://github.com/inspec/yaml-safe_load_stream3".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.2.33".freeze
  s.summary = "Adds YAML.safe_load_stream for safely parsing multi-document YAML streams".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  end
end
