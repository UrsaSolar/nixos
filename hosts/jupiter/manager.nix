{ pkgs, lib, ... }:

{

  imports = [
    ./manager-hardware.nix
    ../../system/base-configuration.nix
    ../../system/base-packages.nix
    ../../system/bootloader.nix
    ../../system/ssh.nix
    ../../system/docker.nix
    ../../system/servers.nix
    #../../system/promtail.nix
  ];

  system.stateVersion = "24.11";
  networking.hostName = "jupiter-manager";

  networking.firewall.enable = false;

  #services.borgbackup.jobs."docker".repo = lib.mkForce "ssh://n4325hol@n4325hol.repo.borgbase.com/./repo";

}
