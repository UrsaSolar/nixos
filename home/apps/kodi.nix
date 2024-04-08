{ pkgs, config, ... }:
{

  programs.kodi = {
    enable = true;
  };

  home.packages = [
    pkgs.kodiPackages.somafm
    pkgs.kodiPackages.netflix
    pkgs.kodiPackages.youtube
    pkgs.kodiPackages.jellyfin
    pkgs.kodiPackages.jellycon
    pkgs.kodiPackages.sponsorblock
    pkgs.kodiPackages.steam-launcher
  ];
}
