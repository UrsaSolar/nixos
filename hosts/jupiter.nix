# Luna.nix

{ pkgs, ... }:
{

  imports = [
    ./jupiter-hardware.nix
  ];

  system.stateVersion = "23.11"; # Historical reference
  nixpkgs.config.allowUnfree = true; #Allow unfree packages
  networking.hostName = "jupiter";

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUHyx/4I3LxcmzRp9d1+MLd4lt0RyctsiqyfOnBXSXl solarbear@terra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxtCabfWGBSoEY4spPRPJLAAT6dM22ElBdnoxCiPDlU kenglish@nixos-asm"
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;  # Deprecated
      # investigate:  https://github.com/NVIDIA/nvidia-docker/issues/1155
      #rootless = {
      #  enable = true;
      #  setSocketVariable = true;
      #};
    };
    #containers.cdi.dynamic.nvidia.enable = true; # not working?
  };

 # environment.systemPackages = with pkgs; [
 # ];

 # Borgmatic
  services.borgmatic = {
    enable = true;
    configurations.docker = {
      source_directories = [ "/jupiterdata/docker/volumes" ];
      repositories = [{
        label = "jupiter-docker";
        path = "ssh://qec41r1b@qec41r1b.repo.borgbase.com/./repo";
      }];
      ssh_command = "${pkgs.openssh}/bin/ssh -i /root/keys/borg/id_ed25519";
      encryption_passcommand = "${pkgs.coreutils}/bin/cat /root/keys/borg/borg.pass";
      keep_daily = 7;
      keep_weekly = 4;
      keep_monthly = 3;
      upload_rate_limit = 5000;
      retries = 3;
      retry_wait = 600;
      #todo:
      #mariadb_databases = ;
      #postgresql_databases = ;

    };
  };

}
