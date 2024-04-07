{ lib, config, pkgs, unstable, ... } :
{

  home.packages = [
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
