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

  networking.hostName = "jupiter-manager";

  #virtualisation.docker.daemon.settings.ip = "192.168.80.23";
  #services.openssh.listenAddresses = [{ addr = "192.168.40.102"; port = 22; }];

  services.keepalived = {
    enable = true;
    openFirewall = true;
    vrrpInstances.docker = {
      state = "BACKUP";
      virtualRouterId = 101;
      interface = "ens18"; 
      priority = 101;
      virtualIps = [
        {
          addr = "192.168.80.80/24";
        }
      ];
    };
  };

  services.borgbackup.jobs."docker" = {
    repo = "ssh://o23tz4xe@o23tz4xe.repo.borgbase.com/./repo";
    user = "root"; # required due to write permissions inside volumes
    environment.BORG_RSH = "ssh -i /root/.ssh/id_ed25519";
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
      "/mnt/docker"
      "/root/borg/db/backup"
    ];
    exclude = [
      "/mnt/docker/syncthing"
      "/mnt/docker/romm"
      "/mnt/docker/ollama"
    ];
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
