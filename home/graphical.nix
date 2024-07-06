{ config, pkgs, unstable, ... }:

{

  imports = [
    ./plasma.nix
    ./apps/firefox.nix
    ./apps/kodi.nix
  ];

}
