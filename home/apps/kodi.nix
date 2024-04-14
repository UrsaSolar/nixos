{ pkgs, config, ... }:
{

 # programs.kodi = {
 #   enable = true;
 # };

  home.packages = [
    ( pkgs.kodi.passthru.withPackages ( kodiPackages: with kodiPackages; [
        somafm
        netflix
        youtube
        jellyfin
        # jellycon
        # sponsorblock
        # steam-launcher
    ]))
  ];
}
