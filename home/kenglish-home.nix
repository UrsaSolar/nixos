 { config, pkgs, ... }:

{
  home.username = "kenglish";
  home.homeDirectory = "/home/kenglish";

  home.shellAliases = {
    # Shell shortcuts
    nm-asm = "nmcli c up \"Allegiant Stadium\"";
    nm-sol = "nmcli c up \"Sol\"";
  };
}

