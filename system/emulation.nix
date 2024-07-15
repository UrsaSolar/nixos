{ pkgs, ... } :
{

  environment.systemPackages = with pkgs; [
    #rpcs3
    retroarch-assets          #unsure if needed, test later
    libretro-core-info        # unsure if needed, test later
    retroarch-joypad-autoconfig   # unsure if needed, test later
    ( retroarch.override
      {
        cores = with libretro; [
          nestopia
          bsnes
          bsnes-hd
          mupen64plus # unsure if both needed
          parallel-n64 # unsure if both needed
          sameboy
          mgba
          desmume
          melonds
          genesis-plus-gx
          blastem
          picodrive
          beetle-saturn
          flycast
          beetle-psx
          beetle-psx-hw
          pcsx2
          play
          ppsspp
          fbneo
        ];
      }
    )
  ];

}
