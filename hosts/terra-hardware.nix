{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  #boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" "nct6687" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ nct6687d ]; # For NCT6687D chip in B650I Lightning
  boot.extraModprobeConfig = ''
  options nct6687 force=1
  ''; # Needed because driver only starts automatically for intel

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.ryzen-smu.enable = true; # https://gitlab.com/leogx9r/ryzen_smu
  #services.hardware.openrgb.enable = true;
  
  boot.initrd.luks.devices."luks-9dc0d76a-c299-482a-9d80-3a2e1c142726" = { # root
    device = "/dev/disk/by-uuid/9dc0d76a-c299-482a-9d80-3a2e1c142726";
    allowDiscards = true;
  };
  boot.initrd.luks.devices."luks-21d8f235-17fa-4484-9843-914b47020f80" = { # swap
    device = "/dev/disk/by-uuid/21d8f235-17fa-4484-9843-914b47020f80"; 
    allowDiscards = true;
  };

  environment.etc.crypttab.text = ''
    luks-c6ef5c75-08af-4bfd-8391-a9e4368e6436 UUID=c6ef5c75-08af-4bfd-8391-a9e4368e6436 /root/secrets/bfd.key
  '';

  fileSystems =
    let
      smb_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,credentials=/etc/secrets/samba/jupiter,uid=1000,gid=1000";
    in {
    "/" = {
      device = "/dev/disk/by-uuid/9882b632-b08a-4fe6-856e-cf4e028aa62d";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/902A-4E6B";
      fsType = "vfat";
    };
    "/mnt/BFD" = {
      device = "/dev/disk/by-uuid/f17b755d-d977-4980-bac0-b8d3d476da28";
      fsType = "ext4";
      options = ["defaults,nofail,x-systemd.device-timeout=5s"];
    };
    "/mnt/jupiter/media" = {
      device = "//192.168.40.10/media";
      fsType = "cifs";
      options = ["${smb_opts}"];
    };
    "/mnt/jupiter/storage" = {
      device = "//192.168.40.10/storage";
      fsType = "cifs";
      options = ["${smb_opts}"];
    };
    "/mnt/jupiter/helium" = {
      device = "//192.168.40.10/helium";
      fsType = "cifs";
      options = ["${smb_opts}"];

    };
    "/mnt/Hell" = {
      device = "/dev/disk/by-uuid/DA227AEC227ACCCF";
      fsType = "ntfs";
      options = ["defaults,noauto,nofail,x-systemd.device-timeout=5s"];
    };
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/7271c40a-d84f-4405-aa0d-18370bc45e8c"; } ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
