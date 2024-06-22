{ config, pkgs, unstable, ... }:
{

  environment.systemPackages = with pkgs; [
    discord
    mangohud
    winetricks
  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    #protontricks.enable = true;
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
