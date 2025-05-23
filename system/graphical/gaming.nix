{ pkgs, ... }:
{

  nixpkgs.config.permittedInsecurePackages = [ "freeimage-unstable-2021-11-01" ];

  environment.systemPackages = with pkgs; [
    discord
    mangohud
    winetricks
    protontricks
    lutris
    pcsx2
    steam-run
    obs-studio
    wine-staging
    vulkan-hdr-layer-kwin6
  ];

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    package = pkgs.steam.override {
      extraPkgs = pkgs: [ pkgs.gamescope ];
    };
    gamescopeSession.enable = true;
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
  #hardware.xone.enable = true; For xbox one dongle, incompatible with 360 pads like my Vader
  hardware.steam-hardware.enable = true;

}
