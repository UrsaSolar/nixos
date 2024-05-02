{ config, pkgs, unstable, ... }:

{

  imports = [
    ./plasma.nix
    ./apps/firefox.nix
    ./apps/kodi.nix
  ];

  # fixes glitches and inconsistency
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaGreen;
    name = "Catppuccin-Mocha-Green-Cursors";
    size = 48;
  };

}
