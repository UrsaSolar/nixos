{ lib, config, pkgs, unstable, ... } :
{

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "discord"
    ];

  programs.mangohud = {
    enable = true;
    settings = {
      preset = 2;
      nodisplay = true;
      toggle_hud = "Shift_R+F12";
      toggle_fps_limit = "Shift_L+F1";
    };
  };
  
  home.packages = [
    unstable.lutris
    unstable.steam
    unstable.discord
    unstable.retroarch
#    unstable.retroarch-assets          #unsure if needed, test later
#    unstable.libretro-core-info        # unsure if needed, test later
#    unstable.retroarch-joypad-assets   # unsure if needed, test later
    #fill with libretro cores
    unstable.libretro.nestopia
    unstable.libretro.bsnes
    unstable.libretro.bsnes-hd
    unstable.libretro.mupen64plus # unsure if both needed
    unstable.libretro.parallel-n64 # unsure if both needed
    unstable.libretro.sameboy
    unstable.libretro.mgba
    unstable.libretro.desmume
    unstable.libretro.melonds
    unstable.libretro.genesis-plus-gx
    unstable.libretro.blastem
    unstable.libretro.picodrive
    unstable.libretro.beetle-saturn
    unstable.libretro.flycast
    unstable.libretro.beetle-psx
    unstable.libretro.beetle-psx-hw
    unstable.libretro.pcsx2
    unstable.libretro.play
    unstable.libretro.ppsspp
    unstable.libretro.fbneo
#    unstable.rpcs3

  ];

}
