 { config, pkgs, ... }:

{
  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";
  home.packages = with pkgs; [
    steam
    discord
    kate
    firefox
    thunderbird
  ];
}

