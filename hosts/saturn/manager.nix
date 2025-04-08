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
  networking.hostName = "saturn-manager";

  networking.firewall.enable = true;

  services.borgbackup.jobs."docker".repo = lib.mkForce "ssh://n4325hol@n4325hol.repo.borgbase.com/./repo";
  
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      extraPerEntryConfig = ''
        quiet console=tty0 console=ttyS0,115200
      '';
    };
  };

  virtualisation.docker.daemon.settings.ip = "192.168.80.22";
  services.qemuGuest.enable = true;
}
