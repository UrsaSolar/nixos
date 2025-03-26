{ pkgs, ... }:
{
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false; # Necessary to be disabled for swarm mode
    daemon.settings = {
      default-address-pools = [{ base = "172.16.0.0/12"; size = 24;}];
      fixed-cidr = "172.16.0.0/12";
      bip = "172.16.0.1/24";
    };
    autoPrune = {
      enable = true;
      dates = "daily";
      flags = [ "--filter 'until=168h'" ];
    };      
  };
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
      "/var/lib/docker/volumes"
      "/root/borg/db/backup"
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

  environment.systemPackages = with pkgs; [
    postgresql_16
    sqlite
  ];

  #services.prometheus.exporters.node.enable = true;

  #services.telegraf = {
  #  enable = true;
  #  environmentFiles = [ "/root/secrets/telegraf.env" ];
  #  extraConfig = {
  #    inputs = {
  #      docker = {
  #        endpoint = "unix:///var/run/docker.sock";
  #        gather_services = false;
  #        source_tag = false;
  #        timeout = "5s";
  #        perdevice = true;
  #        total = false;
  #      };
  #    };
  #    outputs = {
  #      influxdb_v2 = {
  #        urls = ["https://influxdb.proxy.ursa.solar"];
  #        token = "$INFLUXTOKEN";
  #        organization = "ursa-solar";
  #        bucket = "docker";
  #      };
  #    };
  #  };
  #};
  #users.users.telegraf.extraGroups = [ "docker" ];


}
