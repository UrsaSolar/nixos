{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" "nct6687" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ nct6687d ]; # For NCT6687D chip in B650I Lightning
  boot.extraModprobeConfig = ''options nct6687 force=1''; # Needed because driver only starts automatically for intel

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.ryzen-smu.enable = true; # https://gitlab.com/leogx9r/ryzen_smu
  services.hardware.openrgb.enable = true;
  
  boot.initrd.luks.devices."luks-9dc0d76a-c299-482a-9d80-3a2e1c142726" = { # root
    device = "/dev/disk/by-uuid/9dc0d76a-c299-482a-9d80-3a2e1c142726";
    allowDiscards = true;
  };
  boot.initrd.luks.devices."luks-5f407ada-f056-4561-807b-f18eec58d294" = { # bfd
    device = "/dev/disk/by-uuid/5f407ada-f056-4561-807b-f18eec58d294";
    allowDiscards = true;
  };
  boot.initrd.luks.devices."luks-21d8f235-17fa-4484-9843-914b47020f80" = { # swap
    device = "/dev/disk/by-uuid/21d8f235-17fa-4484-9843-914b47020f80"; #swap
    allowDiscards = true;
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9882b632-b08a-4fe6-856e-cf4e028aa62d";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/902A-4E6B";
      fsType = "vfat";
    };

  fileSystems."/mnt/BFD" = {
    device = "/dev/disk/by-uuid/81ee3a15-45c6-4b60-bd07-c9d009e360ac";
    fsType = "btrfs";
  };

  fileSystems."/mnt/jupiter/media" = 
    { device = "//192.168.80.100/media";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/secrets/samba/jupiter,uid=1000,gid=1000"]; };
  fileSystems."/mnt/jupiter/storage" = 
    { device = "//192.168.80.100/storage";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/secrets/samba/jupiter,uid=1000,gid=1000"]; };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/7271c40a-d84f-4405-aa0d-18370bc45e8c";  }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp17s0f4u2u3.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp9s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
