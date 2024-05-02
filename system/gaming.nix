{ config, pkgs, unstable, ... }:
{

  environment.systemPackages = with pkgs; [
    unstable.discord
    unstable.lutris
    mangohud

  ];
  programs.steam = {
    enable = true;
#    remotePlay.openFirewall = true;
  };
  hardware.steam-hardware.enable = true; #Implied by programs.steam.enable=true but kept for posterity
  programs.gamemode = {
    enable = true;
    enableRenice = false;
    # https://mynixos.com/nixpkgs/option/programs.gamemode.settings
    #settings = {};
  };

}
