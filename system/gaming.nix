{ config, pkgs, unstable, ... }:
{

  environment.systemPackages = with pkgs; [
    discord
    lutris
    mangohud
  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
#    remotePlay.openFirewall = true;
  };
  programs.gamemode = {
    enable = true;
    enableRenice = false;
    # https://mynixos.com/nixpkgs/option/programs.gamemode.settings
    #settings = {};
  };

  hardware.xone.enable = true;
  hardware.steam-hardware.enable = true;
}
