{ pkgs, lib, ... }:
{

  system.stateVersion = "24.11";

  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        extraConfig = ''
          serial --unit=0 --speed=115200 --word=8 --parity=no --stop=1
          terminal_input --append serial
          terminal_output --append serial
        '';
      };
    };
    kernelParams = [ "console=tty0" "console=ttyS0,115200" "earlyprintk=ttyS0,115200" "consoleblank=0" ];
  };

  services.qemuGuest.enable = true;

  networking.firewall.enable = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
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
      flags = [ "--all" ];
    };      
  };

  networking.firewall = {
    allowedTCPPorts = [ 
      2377 # Communication with manager nodes
      7946 # Overlay network node discovery
    ];
    allowedUDPPorts = [
      7946 # Overlay network node discovery
      4789 # Overlay network traffic
    ];
    extraCommands = ''
      iptables --insert DOCKER-USER -o ens19 --dst 192.168.40.10/24 --protocol tcp --dport 9001 --jump ACCEPT
      iptables --append DOCKER-USER -o ens19 --src 192.168.40.0/24 --jump DROP
    '';
  };

  fileSystems."/mnt/storage" = {
    device = "192.168.40.10:/mnt/hydrogen/data/storage";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "x-systemd.automount" "noauto" "nofail" "x-systemd.device-timeout=5s" ];
  };

  fileSystems."/mnt/media" = {
    device = "192.168.40.10:/mnt/hydrogen/data/media";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "x-systemd.automount" "noauto" "nofail" "x-systemd.device-timeout=5s" ];
  };

  fileSystems."/mnt/docker" = {
    device = "192.168.40.10:/mnt/helium/data/docker";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "x-systemd.automount" "noauto" "nofail" "x-systemd.device-timeout=5s" ];
  };

  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  #services.prometheus.exporters.node.enable = true;

  services.telegraf = {
    enable = true;
    environmentFiles = [ "/root/secrets/telegraf.env" ];
    extraConfig = {
      agent = {
        interval = "10s";
        round_interval = true;
        flush interval = "10s";
      };
      inputs = {
        docker = {
          endpoint = "unix:///var/run/docker.sock";
          gather_services = false;
          source_tag = false;
          tagexclude = [
            "build_version"
            "com.docker.swarm.node.id"
            "com.docker.swarm.service.id"
            "com.docker.swarm.task.*"
            "container_*"
            "engine_host"
            "org.opencontainers.*"
            "server_version"
            "maintainer"
            "io.portainer.*"
            "com.docker.compose.image"
            "com.docker.compose.project.*"
            "com.docker.compose.oneoff"
            "com.docker.compose.config-hash"
            "com.docker.compose.version"
            "com.docker.compose.container-number"
            "com.docker.compose.service"
            "STACK"
            "com.nvidia.*"
          ];
        };
      };
      outputs = {
        influxdb_v2 = {
          urls = ["https://influxdb.internal.ursa.solar"];
          token = "$INFLUXTOKEN";
          organization = "ursasolar";
          bucket = "docker";
        };
      };
    };
  };
  users.users.telegraf.extraGroups = [ "docker" ];


}
