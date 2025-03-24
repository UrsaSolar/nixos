{ pkgs, ... }:
{

  imports = [
    ./terra-hardware.nix
    ../../system/config/base.nix
    ../../system/config/workstation.nix
    ../../system/gpu/nvidia.nix
    ../../system/graphical/base.nix
    ../../system/graphical/plasma.nix
    ../../system/graphical/gaming.nix
    ../../system/pkgs/base.nix
    ../../system/pkgs/workstation.nix
    ../../system/pkgs/unfree.nix
    ../../system/users/solarbear.nix
    #../../system/promtail.nix
  ];

  system.stateVersion = "23.11"; # Historical reference
  networking.hostName = "terra";
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  boot.supportedFilesystems = [ "ntfs" ];

  programs.coolercontrol.enable=true;

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    shell = pkgs.zsh;
 };

  services.openssh.enable = true;
  programs.adb.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  hardware.ckb-next.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  chaotic.hdr.enable = true;
}
