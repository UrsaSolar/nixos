# terra.nix

{ pkgs, config, ... }:
{

  imports = [
    ./terra-hardware.nix
    ../system/base-configuration.nix
    ../system/base-packages.nix
    ../system/bootloader.nix
    ../system/amd.nix
    ../system/ssh.nix
    ../system/bluetooth.nix
    ../system/graphical.nix
    ../system/plasma.nix
    ../system/gaming.nix
    #../system/emulation.nix
    ../system/promtail.nix
  ];

  system.stateVersion = "23.11"; # Historical reference
  networking.hostName = "terra";
  boot.kernelPackages = pkgs.linuxPackages_zen;



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

  virtualisation.libvirtd.enable = true;

}
