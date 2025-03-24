{ pkgs, ... }:
{

  imports = [
    ./saturn-hardware.nix
    ../../system/base-configuration.nix
    ../../system/base-packages.nix
    ../../system/servers.nix
    ../../system/ssh.nix
    ../../system/nvidia.nix
    ../../system/bootloader.nix
    ../../system/docker-rootful.nix
    #../../system/promtail.nix
  ];

  system.stateVersion = "23.11"; # Historical reference
  networking.hostName = "saturn";
  networking.firewall = {
    enable = false;
    #allowedTCPPorts = [ 47984 47989 48010];
    #allowedUDPPorts = [ 47999 ];
    #allowedUDPPortRanges = [
    #  { from = 48100; to = 48110; }
    #  { from = 48200; to = 48210; }
    #];
  }; 


  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
  };

  services.borgbackup.jobs."docker" = {
    user = "root"; #change later when migrating to rootless
    environment.BORG_RSH = "ssh -i /root/borg/id_ed25519";
    paths = [
      "/var/lib/docker/volumes"
    ];
    exclude = [
      "*/nvidia-driver-vol"
    ];
    repo = "ssh://lc6kjvc3@lc6kjvc3.repo.borgbase.com/./repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/borg/pass";
    };
    compression = "auto,lzma";
    startAt = "03:00:00";
    persistentTimer = true; #trigger immediately if time was missed
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };
  };

}
