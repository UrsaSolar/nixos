{ ... }:
{

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
