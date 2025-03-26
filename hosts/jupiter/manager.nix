{ pkgs, lib, ... }:

{

  imports = [
    ./manager-hardware.nix
    ../../system/config/base.nix
    ../../system/config/docker.nix
    ../../system/pkgs/base.nix
    ../../system/users/server.nix
    ../../system/users/ssh.nix
    #../../system/promtail.nix
  ];

  system.stateVersion = "24.11";
  networking.hostName = "jupiter-manager";

  networking.firewall.enable = false;

  services.borgbackup.jobs."docker".repo = lib.mkForce "ssh://n4325hol@n4325hol.repo.borgbase.com/./repo";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

}
