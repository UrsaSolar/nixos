{ pkgs, ... }:
{

  #services.cockpit.enable = true;
  #services.cockpit.openFirewall = true;

  services.prometheus.exporters.node.enable = true;

}
