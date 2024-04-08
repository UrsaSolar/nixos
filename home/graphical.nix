{ config, pkgs, unstable, ... }:

{

  imports = [
    ./apps/firefox.nix
    ./plasma.nix
  ];

  home.packages = with pkgs; [
    kate
    firefox
    thunderbird
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
