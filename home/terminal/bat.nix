{ config, pkgs, ...}:
{
  programs.bat = {
    enable = true;
    themes = {
      catppuccin = {
        src = pkgs.fetchFromGithub {
          owner = "catppuccin";
          repo = "bat";
          rev = "";
          sha256 = "d714cc1d358ea51bfc02550dabab693f70cccea0";
        };
      };
    };
  };
}
