# Luna.nix

{ config, pkgs, unstable, ... }:

let
  overlay-asus-unstable = final: prev: {
    asusctl = unstable.asusctl;
    supergfxctl = unstable.supergfxctl;
  };
in
{
  
  imports = [
    ./luna-hardware.nix
    ../system/graphical.nix
    ../system/plasma.nix
#    ../system/kodi.nix
  ];

  nixpkgs.overlays = [ overlay-asus-unstable ];

  system.stateVersion = "23.11"; # Historical reference
  nixpkgs.config.allowUnfree = true; #Allow unfree packages
  networking.hostName = "luna";

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    shell = pkgs.zsh;
  };

  # services.openssh.enable = true;
  programs.adb.enable = true;

  # Firewall
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; } # KDE Connect
  ]; 
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; } # KDE Connect
  ];

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings.general = {
      enable = "Source,Sink,Media,Socket"; # Enable A2DP sink
      experimental = true; # Enables battery reporting
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
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use. (Turing or newer).
    powerManagement.finegrained = false;
    # Use the NVidia open source kernel module (not nouveau
    # supported GPUs: https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;
    nvidiaSettings = true; # Enable the Nvidia settings app
    package = config.boot.kernelPackages.nvidiaPackages.stable; #driver version
  };
  # Nvidia Optimus laptop shenanigans
  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:6:0:0";
    nvidiaBusId = "PCI:01:0:0";
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };

  # Asus-linux.org
  services.supergfxd.enable = true;
  services.asusd = {
      enable = true;
      enableUserService = true;
  };


}
