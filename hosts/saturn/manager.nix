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

  networking.hostName = "saturn-manager";

  #virtualisation.docker.daemon.settings.ip = "192.168.80.22";

  services.keepalived = {
    enable = true;
    openFirewall = true;
    vrrpInstances.docker = {
      state = "BACKUP";
      virtualRouterId = 101;
      interface = "ens19"; 
      priority = 100;
      virtualIps = [
        {
          addr = "192.168.80.80/24";
        }
      ];
    };
  };


}
