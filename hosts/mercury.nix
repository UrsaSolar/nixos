# Luna.nix

{ pkgs, ... }:
{

  imports = [
    ./mercury-hardware.nix
  ];

  system.stateVersion = "24.05"; # Historical reference
  nixpkgs.config.allowUnfree = true; #Allow unfree packages
  networking.hostName = "mercury";

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUHyx/4I3LxcmzRp9d1+MLd4lt0RyctsiqyfOnBXSXl solarbear@terra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxtCabfWGBSoEY4spPRPJLAAT6dM22ElBdnoxCiPDlU kenglish@nixos-asm"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuTwUDCM3+GaHuXkLMGYFeRqCcCHuhOblydZhMzmWrn kenglish@nixos-wsl"
    ];
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
        authorizedKeys = [ 
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUHyx/4I3LxcmzRp9d1+MLd4lt0RyctsiqyfOnBXSXl solarbear@terra"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxtCabfWGBSoEY4spPRPJLAAT6dM22ElBdnoxCiPDlU kenglish@nixos-asm"
        ];
        hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
      };
      postCommands = ''
        # Automatically ask for the password on SSH login
        echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
      '';
    };
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings = {
      default-address-pools = [{ base = "172.16.0.0/12"; size = 28;}];
      fixed-cidr = "172.168.0.0/12";
      bip = "172.16.0.1/24";
    };
  };
  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };
  networking.firewall.enable = false;

  virtualisation.libvirtd.enable = true;

  #virtualisation.docker.enable = true;
  #virtualisation.podman = {
    #enable = true;
    #dockerCompat = true;
    #dockerSocket.enable = true;
  #};

 # environment.systemPackages = with pkgs; [
 # ];

 # Borgmatic
#  services.borgmatic = {
#    enable = true;
#    configurations.docker = {
#      source_directories = [ "/var/lib/docker/volumes" ];
#      repositories = [{
#        label = "TEMPLATE-docker";
#        path = "ssh://PLACEHOLDER.repo.borgbase.com/./repo";
#      }];
#      ssh_command = "${pkgs.openssh}/bin/ssh -i /root/keys/borg/id_ed25519";
#      encryption_passcommand = "${pkgs.coreutils}/bin/cat /root/keys/borg/borg.pass";
#      keep_daily = 7;
#      keep_weekly = 4;
#      keep_monthly = 3;
#      upload_rate_limit = 5000;
#      retries = 3;
#      retry_wait = 600;
      #todo:
      #mariadb_databases = ;
      #postgresql_databases = ;

#    };
#  };

}
