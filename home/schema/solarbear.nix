{ ... }:{

  imports = [
    ../config/base.nix
    ../config/workstation.nix
    ../terminal/ssh/solarbear.nix
  ];

  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";

}
