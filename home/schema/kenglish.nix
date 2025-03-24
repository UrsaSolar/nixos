{ ... }:{

  imports = [
    ../config/base.nix
    ../config/workstation.nix
    ../terminal/ssh/kenglish.nix
  ];

  home.username = "kenglish";
  home.homeDirectory = "/home/kenglish";

}
