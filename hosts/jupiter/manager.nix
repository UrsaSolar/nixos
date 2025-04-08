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

  networking.firewall.enable = true;

  services.borgbackup.jobs."docker".repo = lib.mkForce "ssh://n4325hol@n4325hol.repo.borgbase.com/./repo";
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker.daemon.settings.ip = "192.168.80.124";
  #services.openssh.listenAddresses = [{ addr = "192.168.40.102"; port = 22; }];
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s18.useDHCP = lib.mkDefault true;
}
