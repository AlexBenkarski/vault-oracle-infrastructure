# -*- encoding: utf-8 -*-
# stub: hydra_controlplane_client 1.1.112 ruby lib

Gem::Specification.new do |s|
  s.name = "hydra_controlplane_client".freeze
  s.version = "1.1.112"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Universal Agent team".freeze]
  s.date = "2024-12-11"
  s.description = "Hydra ControlPlane Ruby Client".freeze
  s.email = ["oci-siem-agent_us_grp@oracle.com".freeze]
  s.homepage = "https://confluence.oci.oraclecorp.com".freeze
  s.licenses = ["UPL-1.0".freeze, "Apache-2.0".freeze]
  s.rubygems_version = "3.2.33".freeze
  s.summary = "Hydra ControlPlane Ruby Client".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<oci>.freeze, ["~> 2"])
  else
    s.add_dependency(%q<oci>.freeze, ["~> 2"])
  end
end
