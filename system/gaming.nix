{ pkgs, unstable, ... }:
{

  nixpkgs.config.permittedInsecurePackages = [ "freeimage-unstable-2021-11-01" ];

  environment.systemPackages = with pkgs; [
    discord
    discord-canary
    vesktop
    mangohud
    winetricks
    protontricks
    lutris
    mame
    pcsx2
    steam-run
    obs-studio
  ];

  programs.steam = {
    enable = true;
    extraCompatPackages = [ unstable.proton-ge-bin ];
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [ gamescope ];
    };
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
