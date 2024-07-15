{ ... }:
{
  imports = [
    ./terminal/ssh-work.nix
  ];

  home.username = "kenglish";
  home.homeDirectory = "/home/kenglish";

  home.shellAliases = {
    # Shell shortcuts
    nm-asm = "nmcli c up \"Allegiant Stadium\"";
    nm-sol = "nmcli c up \"Sol\"";
    hm-rebuild = "home-manager switch --flake $NIXOSDIR && source $XDG_CONFIG_HOME/zsh/.zshrc && rm $XDG_CACHE_HOME/ksycoca5*";
  };
}

