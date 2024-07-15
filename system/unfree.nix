{ lib, ... }:
{
nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "unrar"
    "steam"
    "discord"
    "nvidia-container-toolkit"
    "nvidia-x11"
    "nvidia-persistenced"
  ];

}
