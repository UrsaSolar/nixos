# ASM.nix

{ config, pkgs, ... }:
{
  system.stateVersion = "23.11"; # Historical reference
  networking.hostName = "nixos-asm"; # Define your hostname.

  users.users.kenglish = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  services.openssh.enable = true;
  networking.firewall.enable = false; # Not needed due to host firewall

}
