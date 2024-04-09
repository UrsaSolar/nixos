{ config, pkgs, ... }:
{

  programs.fish = {
    enable = true;
    shellInit = ''fish_config theme save "Catppuccin Mocha"'';
    plugins = [
      {
        name = "catppuccin"; src = pkgs.fetchFromGitHub {
        owner = "catppuccin"; repo = "fish"; rev = "main";
        sha256 = "Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
        };
      }
    ];
  };

}
