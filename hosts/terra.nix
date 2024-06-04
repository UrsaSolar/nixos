# terra.nix

{ config, pkgs, unstable, ... }:
{

  imports = [
    ./terra-hardware.nix
    ../system/graphical.nix
    ../system/plasma.nix
    ../system/gaming.nix
    ../system/emulation.nix
  ];

  system.stateVersion = "23.11"; # Historical reference
  nixpkgs.config.allowUnfree = true; #Allow unfree packages
  networking.hostName = "terra";

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport32Bit = true;
  hardware.ckb-next.enable = true;

}
