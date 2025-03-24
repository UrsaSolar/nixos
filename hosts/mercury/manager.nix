{ pkgs, lib, ... }:

{

  imports = [
    ./mercury-manager-hardware.nix
    ../../system/base-configuration.nix
    ../../system/base-packages.nix
    ../../system/bootloader.nix
    ../../system/ssh.nix
    ../../system/docker-rootful.nix
    ../../system/servers.nix
    #../../system/promtail.nix
  ];

  system.stateVersion = "24.05";
  networking.hostName = "mercury";

  networking.firewall.enable = false;

  services.borgbackup.jobs."docker".repo = lib.mkForce "ssh://n4325hol@n4325hol.repo.borgbase.com/./repo";

}
