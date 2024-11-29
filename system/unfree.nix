{ lib, ... }:
{
nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "unrar"
    "steam"
    "steam-run"
    "steam-original"
    "steam-unwrapped"
    "discord"
    "discord-canary"
    "nvidia-container-toolkit"
    "nvidia-x11"
    "nvidia-persistenced"
    "xow_dongle-firmware"
  ];

}
