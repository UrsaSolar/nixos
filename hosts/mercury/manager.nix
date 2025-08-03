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

  networking.hostName = "mercury-manager";

  virtualisation.docker.daemon.settings.ip = "192.168.80.21";
  #services.openssh.listenAddresses = [{ addr = "192.168.40.104"; port = 22; }];
}
