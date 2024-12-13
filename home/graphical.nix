{ ... }:

{

  imports = [
    ./plasma.nix
    ./apps/firefox.nix
    ./apps/kodi.nix
  ];

  services.easyeffects = {
    enable = true;
  };

}
