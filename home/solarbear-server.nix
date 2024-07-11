{ config, pkgs, unstable, ... }:

{
  
  imports = [
#    ./graphical.nix
#    ./apps/gaming.nix
#    ./apps/emulation.nix
  ];

  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";

  home.shellAliases = {
    hm-rebuild = "home-manager switch --flake $NIXOSDIR#solarbear-server && source $XDG_CONFIG_HOME/zsh/.zshrc && rm $XDG_CACHE_HOME/ksycoca5*";
  };

}
