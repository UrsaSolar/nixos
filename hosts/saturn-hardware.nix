{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

# Boot
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F99E-E759";
    fsType = "vfat"; };
  # Root
  boot.initrd.luks.devices."luks-41280705-8a8f-44e0-b9e9-c4a43803580a".device = "/dev/disk/by-uuid/41280705-8a8f-44e0-b9e9-c4a43803580a";
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/313101c0-f1b5-4afb-b125-ac6d8fd94c84";
      fsType = "ext4"; };
  # Home
  boot.initrd.luks.devices."luks-3737e9de-2612-4bc8-a8f6-cab411d286fb".device = "/dev/disk/by-uuid/3737e9de-2612-4bc8-a8f6-cab411d286fb";
  fileSystems."/home" = 
    { device = "/dev/disk/by-uuid/178219dd-c801-41eb-a861-c6c7d0f3748c";
      fsType = "ext4"; };
  # Data
#  boot.initrd.luks.devices."luks-c4c5db23-12f9-4869-888a-0c469aedce37".device = "/dev/disk/by-uuid/c4c5db23-12f9-4869-888a-0c469aedce37";
#  fileSystems."/mnt/data" = 
#    { device = "/dev/disk/by-uuid/4516df7b-4550-4199-9c3c-a2e53f6b65e0";
#      fsType = "ext4"; };
  # Jupiter    
  fileSystems."/mnt/jupiter-media" = 
    { device = "//192.168.80.100/media";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/secrets/samba/jupiter,uid=1000,gid=1000"]; };
  fileSystems."/mnt/jupiter-storage" = 
    { device = "//192.168.80.100/storage";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/secrets/samba/jupiter,uid=1000,gid=1000"]; };
#  swapDevices =
#  [ { device = "/dev/disk/by-uuid/bd82fcdc-77ed-435c-b5bf-2cd6adc00a6b"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.interfaces.enp4s0.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };
}
