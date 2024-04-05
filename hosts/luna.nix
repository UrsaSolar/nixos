# Luna.nix

{ config, pkgs, unstable, ... }:
{

## Trying to figure out how to enable unstable asusctl/supergfxctl
#disabledModules = [
#    "nixos/modules/services/hardware/asusd.nix"
#    "nixos/modules/programs/rog-control-center.nix"
#    "nixos/modules/services/hardware/supergfxctl.nix"
#  ];
#  imports = [
#    <nixos-unstable/nixos/modules/services/hardware/asusd.nix>
#    <nixos-unstable/nixos/modules/programs/rog-control-center.nix>
#    <nixos-unstable/nixos/modules/services/hardware/supergfxd.nix>
#  ];

  system.stateVersion = "23.11"; # Historical reference
  nixpkgs.config.allowUnfree = true; #Allow unfree packages
  networking.hostName = "luna";

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };


  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

#  environment.systemPackages = [
#    unstable.asusctl
#    unstable.supergfxctl
#  ];

  # Asus-linux.org
  services.supergfxd.enable = true;
  services.asusd = {
      enable = true;
      enableUserService = true;
  };


}
