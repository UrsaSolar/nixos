{ ... }:

{

  imports = [
    ./plasma.nix
    ../apps/firefox.nix
  ];

  services.easyeffects = {
    enable = true;
  };

}
