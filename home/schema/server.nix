{ ... }:{

  imports = [
    ../config/base.nix
    ../config/server.nix
    ../terminal/ssh/solarbear.nix
  ];

  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";

}
