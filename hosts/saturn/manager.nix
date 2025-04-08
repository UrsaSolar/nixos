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
  
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        extraConfig = ''
          serial --unit=0 --speed=115200 --word=8 --parity=no --stop=1
          terminal_input --append serial
          terminal_output --append serial
        '';
      };
    };
    kernelParams = [ "console=tty0 console=ttyS0,115200 earlyprintk=ttyS0,115200 consoleblank=0" ]
  };

  virtualisation.docker.daemon.settings.ip = "192.168.80.22";
  services.qemuGuest.enable = true;
}
