{ pkgs, ... } :
{

  home.packages = with pkgs; [
    retroarch
    retroarch-assets          #unsure if needed, test later
    libretro-core-info        # unsure if needed, test later
    retroarch-joypad-assets   # unsure if needed, test later
    libretro.nestopia
    libretro.bsnes
    libretro.bsnes-hd
    libretro.mupen64plus # unsure if both needed
    libretro.parallel-n64 # unsure if both needed
    libretro.sameboy
    libretro.mgba
    libretro.desmume
    libretro.melonds
    libretro.genesis-plus-gx
    libretro.blastem
    libretro.picodrive
    libretro.beetle-saturn
    libretro.flycast
    libretro.beetle-psx
    libretro.beetle-psx-hw
    libretro.pcsx2
    libretro.play
    libretro.ppsspp
    libretro.fbneo
    #rpcs3

  ];

}
