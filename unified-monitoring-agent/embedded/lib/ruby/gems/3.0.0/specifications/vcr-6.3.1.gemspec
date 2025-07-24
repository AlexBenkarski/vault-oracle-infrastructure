# -*- encoding: utf-8 -*-
# stub: vcr 6.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "vcr".freeze
  s.version = "6.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Myron Marston".freeze, "Kurtis Rainbolt-Greene".freeze, "Olle Jonsson".freeze]
  s.date = "2024-08-20"
  s.description = "Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.".freeze
  s.email = ["kurtis@rainbolt-greene.online".freeze]
  s.homepage = "https://benoittgt.github.io/vcr".freeze
  s.licenses = ["Hippocratic-2.1".freeze, "MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7".freeze)
  s.rubygems_version = "3.2.33".freeze
  s.summary = "Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<base64>.freeze, [">= 0"])
  else
    s.add_dependency(%q<base64>.freeze, [">= 0"])
  end
end
