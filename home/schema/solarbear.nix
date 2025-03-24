{ ... }:{

  imports = [
    ../config/base.nix
    ../config/workstation.nix
    ../config/graphical.nix
    ../config/gaming.nix
    ../apps/firefox.nix
    ../terminal/ssh/solarbear.nix
  ];

  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";

}
