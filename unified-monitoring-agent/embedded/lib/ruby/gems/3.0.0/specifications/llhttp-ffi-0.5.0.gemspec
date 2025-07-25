# -*- encoding: utf-8 -*-
# stub: llhttp-ffi 0.5.0 ruby lib
# stub: ext/Rakefile

Gem::Specification.new do |s|
  s.name = "llhttp-ffi".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Bryan Powell".freeze]
  s.date = "2023-03-29"
  s.description = "Ruby FFI bindings for llhttp.".freeze
  s.email = "bryan@bryanp.org".freeze
  s.extensions = ["ext/Rakefile".freeze]
  s.files = ["ext/Rakefile".freeze]
  s.homepage = "https://github.com/bryanp/llhttp/".freeze
  s.licenses = ["MPL-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.2.33".freeze
  s.summary = "Ruby FFI bindings for llhttp.".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<ffi-compiler>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<rake>.freeze, ["~> 13.0"])
  else
    s.add_dependency(%q<ffi-compiler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
  end
end
