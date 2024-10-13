# Luna.nix

{ pkgs, ... }:

let
  authorized_keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUHyx/4I3LxcmzRp9d1+MLd4lt0RyctsiqyfOnBXSXl solarbear@terra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxtCabfWGBSoEY4spPRPJLAAT6dM22ElBdnoxCiPDlU kenglish@nixos-asm"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuTwUDCM3+GaHuXkLMGYFeRqCcCHuhOblydZhMzmWrn kenglish@nixos-wsl"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINivT/RWXZhBr4CUXGlsmHzq9QQDsJ7w009gKpetqgfY kenglish@nixos-wsl"
    ];
in

{

  imports = [
    ./mercury-hardware.nix
    ../system/base-configuration.nix
    ../system/base-packages.nix
    ../system/bootloader.nix
    ../system/ssh.nix
    ../system/docker-rootless.nix
    ../system/servers.nix
  ];

  system.stateVersion = "24.05"; # Historical reference
  networking.hostName = "mercury";

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" ];
    shell = pkgs.zsh;
    linger = true;
    openssh.authorizedKeys.keys = authorized_keys;
  };

  # SSH Unlocking - https://wiki.nixos.org/w/index.php?title=Remote_disk_unlocking
  networking.firewall.enable = false;
  services.openssh.openFirewall = true;

  services.borgbackup.jobs."docker" = {
    user = "root"; # required due to write permissions inside volumes
    environment.BORG_RSH = "ssh -i /root/borg/id_ed25519";
    preHook = ''
      if find /root/borg/db/postgres -mindepth 1 -maxdepth 1 | read; then
        for FILE in /root/borg/db/postgres/*; do
          source $FILE;
          PGPASSWORD=$DB_PASS ${pkgs.postgresql_16}/bin/pg_dump -U $DB_USER -h $DB_HOST -p $DB_PORT $DB_NAME \
            > /root/borg/db/backup/$DB_NAME.postgres;
        done
      fi
      if find /root/borg/db/sqlite -mindepth 1 -maxdepth 1 | read; then
        for FILE in /root/borg/db/sqlite/*; do
          source $FILE;
          ${pkgs.sqlite}/bin/sqlite3 $DB_FILE .dump > /root/borg/db/backup/$DB_NAME.sqlite
        done
      fi
    '';
    paths = [
      "/home/solarbear/.local/share/docker/volumes"
      "/root/borg/db/backup"
      "/home/solarbear/docker"
    ];
    repo = "ssh://n4325hol@n4325hol.repo.borgbase.com/./repo";
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

  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    postgresql_16
    sqlite
  ];



  # KUBERNETES TIME
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/cluster/k3s/docs/USAGE.md
  #services.k3s.enable = true;
  #services.k3s.role = "server";

}
