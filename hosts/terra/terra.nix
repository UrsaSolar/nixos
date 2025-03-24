# terra.nix

{ pkgs, ... }:
{

  imports = [
    ./terra-hardware.nix
    ../../system/base-configuration.nix
    ../../system/base-packages.nix
    ../../system/bootloader.nix
    #../../system/amd.nix
    ../../system/nvidia.nix
    ../../system/ssh.nix
    ../../system/bluetooth.nix
    ../../system/graphical.nix
    ../../system/plasma.nix
    ../../system/gaming.nix
    ../../system/promtail.nix
    ../../system/unfree.nix
    # ../../system/docker-rootful.nix
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

  chaotic.hdr.enable = true;
}
