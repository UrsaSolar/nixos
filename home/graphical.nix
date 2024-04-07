{ config, pkgs, unstable, ... }:

{

  imports = [
    ./apps/firefox.nix
  ];

  home.packages = with pkgs; [
    kate
    firefox
    thunderbird
  ];

  #home.pointerCursor = {
  #  gtk.enable = true;
  #  x11.enable = true;
  #  package = pkgs.catppuccin-cursors;
  #  name = "Catppuccin-Mocha-Green-Cursors";
  #  size = 48;
  #};

  #home.file.".icons/default".source = "${pkgs.catppuccin-cursors.mochaGreen}/share/icons/Catppuccin-Mocha-/Catppuccin-Mocha-Green-Cursors"; 
    
  programs.plasma = {
    enable = true;
  };

}
