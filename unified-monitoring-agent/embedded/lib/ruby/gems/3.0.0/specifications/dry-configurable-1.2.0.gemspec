# -*- encoding: utf-8 -*-
# stub: dry-configurable 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "dry-configurable".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "bug_tracker_uri" => "https://github.com/dry-rb/dry-configurable/issues", "changelog_uri" => "https://github.com/dry-rb/dry-configurable/blob/main/CHANGELOG.md", "source_code_uri" => "https://github.com/dry-rb/dry-configurable" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Holland".freeze]
  s.date = "2024-07-02"
  s.description = "A mixin to add configuration functionality to your classes".freeze
  s.email = ["andyholland1991@aol.com".freeze]
  s.homepage = "https://dry-rb.org/gems/dry-configurable".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.0.0".freeze)
  s.rubygems_version = "3.2.33".freeze
  s.summary = "A mixin to add configuration functionality to your classes".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<dry-core>.freeze, ["~> 1.0", "< 2"])
    s.add_runtime_dependency(%q<zeitwerk>.freeze, ["~> 2.6"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
  else
    s.add_dependency(%q<dry-core>.freeze, ["~> 1.0", "< 2"])
    s.add_dependency(%q<zeitwerk>.freeze, ["~> 2.6"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
