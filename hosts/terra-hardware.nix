{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."luks-09fbdde3-2f22-43b4-82d5-ab04211d8131".device = "/dev/disk/by-uuid/09fbdde3-2f22-43b4-82d5-ab04211d8131"; #root
  boot.initrd.luks.devices."luks-5f407ada-f056-4561-807b-f18eec58d294".device = "/dev/disk/by-uuid/5f407ada-f056-4561-807b-f18eec58d294"; #bfd
  boot.initrd.luks.devices."luks-9ca573dd-11ec-4bf6-b2e0-37e31f027ea1".device = "/dev/disk/by-uuid/9ca573dd-11ec-4bf6-b2e0-37e31f027ea1"; #swap

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b074e53f-588a-411c-b322-a04cbc9fcb14";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7C83-1040";
      fsType = "vfat";
    };

  fileSystems."/mnt/BFD" = {
    device = "/dev/disk/by-uuid/81ee3a15-45c6-4b60-bd07-c9d009e360ac";
    fsType = "btrfs";
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/7efb1fce-6e7f-45c0-b98a-2057e0b2005c"; }
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
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
