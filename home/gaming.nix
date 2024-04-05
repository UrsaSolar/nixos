{ config, pkgs, ... } :
{

  programs.mangohud = {
    enable = true;
    settings = {
      preset = 2;
      nodisplay = true;
      toggle_hud = "Shift_R+F12";
      toggle_fps_limit = "Shift_L+F1";
    };
  };

}
