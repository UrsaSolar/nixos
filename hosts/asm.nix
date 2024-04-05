# ASM.nix

{ config, pkgs, ... }:
{
  system.stateVersion = "23.11"; # Historical reference
  networking.hostName = "nixos-asm"; # Define your hostname.

  users.users.kenglish = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmWTYLdAzG37mtBzXLRwUXRzhJlPRryu10PjyHuIDtkS2i8DJ/1UJRbbHUQFodYCJQPA7YD3ZujFCwO2ZsKsvv9Sqa9DpdttteR8JHWGIlcOmEz7DyO4ttpLdRZD/w6KBpZEprB5xgESEkwk4TirwTbK6I/kSqfWee8HvPPBG4o4NdZpJK6SZvzKPowMis0PkQGdea0IjgByNlXdzngZPeRZ1idnBA3IbqyOC5Diwzh+/YpD37bFOdwj6NquK9cSZ2htDqPchux628x1KfE0AikTiGbLUsffh+bvZTtcTi8V4BBLFJRzQytiwtiPiv3QwVCKCYSakx5JuiRd3oqrsSwSzyFfSI1TN12efb8FhRpAB15UKppIqE1Vn9Mqp3gL594tsd3uTQTl+zCMGF+TmNB0u2ifBJw+OBNMht862VmUYvEMIO866gRA1tW5DJq3rqYsyBM/qwh/pt9S8JM9f+gfp/rGQbqLshyVqQOVKRsaaCY0N2z6tmFU70QralhjU= azuread\kyleenglish@DESKTOP-IPL03K8"
    ];
  };

  services.openssh.enable = true;
  networking.firewall.enable = false; # Not needed due to host firewall

}
