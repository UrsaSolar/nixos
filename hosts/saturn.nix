{ pkgs, ... }:
{

  imports = [
    ./saturn-hardware.nix
    ../system/base-configuration.nix
    ../system/base-packages.nix
    ../system/nvidia.nix
    ../system/bootloader.nix
    ../system/docker-rootful.nix
    ../system/ssh.nix
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUHyx/4I3LxcmzRp9d1+MLd4lt0RyctsiqyfOnBXSXl solarbear@terra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxtCabfWGBSoEY4spPRPJLAAT6dM22ElBdnoxCiPDlU kenglish@nixos-asm"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuTwUDCM3+GaHuXkLMGYFeRqCcCHuhOblydZhMzmWrn kenglish@nixos-wsl"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINivT/RWXZhBr4CUXGlsmHzq9QQDsJ7w009gKpetqgfY kenglish@nixos-wsl"
    ];
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
