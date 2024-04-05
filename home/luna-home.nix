{ config, pkgs, ... }:

{
  
  imports = [
    ./gaming.nix
    ./graphical.nix
  ];

  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";
  home.packages = with pkgs; [
    steam
    discord
    kate
    firefox
    thunderbird
  ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "steam"
      "steam-run"
      "steam-original"
      "discord"
    ];
  
}
