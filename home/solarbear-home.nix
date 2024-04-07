{ config, pkgs, unstable, ... }:

{
  
  imports = [
    ./gaming.nix
#    ./graphical.nix
  ];

  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";
  home.packages = with pkgs; [
    kate
    firefox
    thunderbird
  ];

}
