{ config, pkgs, unstable, ... }:
#let
#  overlay-steam-unstable = final: prev: {
#    steam = unstable.steam;
#    protontricks = unstable.protontricks;
#  };
#in
{

  #nixpkgs.overlays = [ overlay-steam-unstable ]; 
  nixpkgs.config.permittedInsecurePackages = [ "freeimage-unstable-2021-11-01" ];

  environment.systemPackages = with pkgs; [
    discord
    mangohud
    winetricks
    protontricks
    lutris
    wine-staging
    emulationstation-de
  ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    #protontricks = {
    #  enable = true;
    #};
#    remotePlay.openFirewall = true;
  };

  programs.gamemode = {
    enable = true;
    enableRenice = false;
    # https://mynixos.com/nixpkgs/option/programs.gamemode.settings
    #settings = {};
  };

  #programs.lutris.enable = true;
  hardware.xone.enable = true;
  hardware.steam-hardware.enable = true;
}
