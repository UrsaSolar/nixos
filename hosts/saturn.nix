# Luna.nix

{ config, pkgs, ... }:
{

  imports = [
    ./saturn-hardware.nix
  ];

  system.stateVersion = "23.11"; # Historical reference
  #nixpkgs.config.allowUnfree = true; #Allow unfree packages
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
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuTwUDCM3+GaHuXkLMGYFeRqCcCHuhOblydZhMzmWrn kenglish@nixos-wsl"
        ];
        hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
      };
      postCommands = ''
        # Automatically ask for the password on SSH login
        echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
      '';
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
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
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [ "--filter 'until=168h'" ];
      };      
      extraOptions = ''
        --tlsverify \
        --tlscacert=/home/solarbear/certs/ca.crt \
        --tlscert=/home/solarbear/certs/saturn.crt \
        --tlskey=/home/solarbear/certs/saturn.key
      '';
      listenOptions = [
        "/run/docker.sock"
        "0.0.0.0:2376"
      ];
      enableNvidia = true;  # Deprecated
      # investigate:  https://github.com/NVIDIA/nvidia-docker/issues/1155
      #rootless = {
      #  enable = true;
      #  setSocketVariable = true;
      #};
    };
    #containers.cdi.dynamic.nvidia.enable = true; # not working?
  };

 # Borgmatic
  services.borgmatic = {
    enable = true;
    configurations.docker = {
      source_directories = [ "/var/lib/docker/volumes" ];
      repositories = [{
        label = "saturn-docker";
        path = "ssh://xpa4440n@xpa4440n.repo.borgbase.com/./repo";
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


  # Nvidia
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"]; # Load nvidia driver
  hardware.nvidia = {
   modesetting.enable = true; # Modesetting is required for Optimus 
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;
    # REQUIRES SECOND GPU. Fine-grained power management. Turns off GPU when not in use. (Turing or newer).
    powerManagement.finegrained = false;
    # Use the NVidia open source kernel module (not nouveau
    # supported GPUs: https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;
    nvidiaSettings = false; # Enable the Nvidia settings app
    package = config.boot.kernelPackages.nvidiaPackages.stable; #driver version
  };

}
