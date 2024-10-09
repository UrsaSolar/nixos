# Luna.nix

{ pkgs, ... }:

let
  authorized_keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUHyx/4I3LxcmzRp9d1+MLd4lt0RyctsiqyfOnBXSXl solarbear@terra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxtCabfWGBSoEY4spPRPJLAAT6dM22ElBdnoxCiPDlU kenglish@nixos-asm"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuTwUDCM3+GaHuXkLMGYFeRqCcCHuhOblydZhMzmWrn kenglish@nixos-wsl"
    ];
in

{

  imports = [
    ./mercury-hardware.nix
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
  boot.initrd = {
    availableKernelModules = [ "igc" ];
    network = {
      enable = true;
      udhcpc.enable = true;
      flushBeforeStage2 = true;
      ssh = {
        enable = true;
        port = 22;
        authorizedKeys = authorized_keys;
        hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
      };
      postCommands = ''
        # Automatically ask for the password on SSH login
        echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
      '';
    };
  };

  networking.firewall.enable = false;
  services.openssh.openFirewall = true;

  services.borgbackup.jobs."docker" = {
    user = "root"; # required due to write permissions inside volumes
    environment.BORG_RSH = "ssh -i /root/borg/id_ed25519";
    preHook = ''
      for FILE in /root/borg/db/postgres/*; do
        source $FILE;
        PGPASSWORD=$DB_PASS ${pkgs.postgresql_16}/bin/pg_dump -U $DB_USER -h $DB_HOST -p $DB_PORT $DB_NAME > /root/borg/db/backup/$DB_NAME.sql;
      done
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
  ];



  # KUBERNETES TIME
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/cluster/k3s/docs/USAGE.md
  #services.k3s.enable = true;
  #services.k3s.role = "server";

}
