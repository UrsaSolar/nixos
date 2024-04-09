{ config, pkgs, ... }:
{

  programs.fish = {
    enable = true;
    shellInit = ''fish_config theme save "Catppuccin Mocha"'';
    plugins = [
      {
        name = "catppuccin"; src = pkgs.fetchFromGithhub {
        owner = "catppucin"; repo = "fish"; };
      }
    ];
  };

}
