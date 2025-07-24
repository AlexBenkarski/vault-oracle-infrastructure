# -*- encoding: utf-8 -*-
# stub: serverengine 2.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "serverengine".freeze
  s.version = "2.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sadayuki Furuhashi".freeze]
  s.date = "2024-10-22"
  s.description = "A framework to implement robust multiprocess servers like Unicorn".freeze
  s.email = ["frsyuki@gmail.com".freeze]
  s.homepage = "https://github.com/fluent/serverengine".freeze
  s.licenses = ["Apache 2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.2.33".freeze
  s.summary = "ServerEngine - multiprocess server framework".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<sigdump>.freeze, ["~> 0.2.2"])
    s.add_runtime_dependency(%q<base64>.freeze, ["~> 0.1"])
    s.add_runtime_dependency(%q<logger>.freeze, ["~> 1.4"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.12.0"])
    s.add_development_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.5.0"])
    s.add_development_dependency(%q<rake-compiler>.freeze, ["~> 0.9.4"])
    s.add_development_dependency(%q<timecop>.freeze, ["~> 0.9.5"])
    s.add_development_dependency(%q<rr>.freeze, ["~> 3.1"])
  else
    s.add_dependency(%q<sigdump>.freeze, ["~> 0.2.2"])
    s.add_dependency(%q<base64>.freeze, ["~> 0.1"])
    s.add_dependency(%q<logger>.freeze, ["~> 1.4"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.12.0"])
    s.add_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.5.0"])
    s.add_dependency(%q<rake-compiler>.freeze, ["~> 0.9.4"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.9.5"])
    s.add_dependency(%q<rr>.freeze, ["~> 3.1"])
  end
end
