{ config, pkgs, unstable, ... }:

{
  
  imports = [
    ./graphical.nix
    ./apps/gaming.nix
    ./apps/emulation.nix
  ];

  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";

}
