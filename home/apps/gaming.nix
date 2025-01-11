{ ... } :
{
  #  imports = [
  #  ./emulation.nix
  #];

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
      preset = 0;
      nodisplay = true;
      toggle_hud = "Shift_R+F12";
      toggle_fps_limit = "Shift_L+F1";
      fps_limit = "0,30,60,120";
    };
  };
  

}
