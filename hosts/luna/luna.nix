{ lib, ... }:
{
  
  imports = [
    ./luna-hardware.nix
    ../../system/base-configuration.nix
    ../../system/base-packages.nix
    ../../system/bootloader.nix
    ../../system/users.nix
    ../../system/nvidia-optimus.nix
    ../../system/bluetooth.nix
    ../../system/graphical.nix
    ../../system/plasma.nix
#    ../../system/kodi.nix
    ../../system/promtail.nix
  ];

  system.stateVersion = "23.11"; # Historical reference
  networking.hostName = "luna";

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


  # Nvidia Optimus laptop shenanigans
  hardware.nvidia = {
    powerManagement.enable = lib.mkForce false;
    nvidiaSettings = lib.mkForce true; # Enable the Nvidia settings app
  };
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
