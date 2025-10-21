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
  services.telegraf.extraConfig.inputs.docker.gather_services = lib.mkForce true;
  
  services.keepalived = {
    enable = true;
    openFirewall = true;
    vrrpInstances.docker = {
      state = "MASTER";
      virtualRouterId = 101;
      interface = "ens18"; 
      priority = 200;
      virtualIps = [
        {
          addr = "192.168.80.80/24";
        }
      ];
    };
  };

}
