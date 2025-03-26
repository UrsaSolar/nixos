{ pkgs, ... }:
{

  imports = [
    #./template-hardware.nix
    ../../system/config/base.nix
    #../../system/config/docker.nix
    #../../system/config/workstation.nix
    #../../system/gpu/amd.nix
    #../../system/gpu/nvidia.nix
    #../../system/gpu/optimus.nix
    #../../system/graphical/base.nix
    #../../system/graphical/plasma.nix
    #../../system/graphical/gaming.nix
    ../../system/pkgs/base.nix
    #../../system/pkgs/workstation.nix
    ../../system/pkgs/unfree.nix
    ../../system/users/solarbear.nix
    ../../system/users/ssh.nix
    #../../system/promtail.nix
  ];

  system.stateVersion = "24.11"; # Historical reference
  networking.hostName = "terra";

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

}
