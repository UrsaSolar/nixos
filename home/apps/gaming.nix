{ lib, config, pkgs, unstable, ... } :
{

#  nixpkgs.config.allowUnfreePredicate = pkg:
#    builtins.elem (lib.getName pkg) [
#      "steam"
#      "steam-original"
#      "discord"
#    ];

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      preset = 2;
      nodisplay = true;
      toggle_hud = "Shift_R+F12";
      toggle_fps_limit = "Shift_L+F1";
    };
  };
  

}
