{ config, pkgs, unstable, ... }:

{
  
  imports = [
    ./terminal/ssh-home.nix
  ];

  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";

  home.shellAliases = {
    hm-rebuild = "home-manager switch --flake $NIXOSDIR#solarbear-server && source $XDG_CONFIG_HOME/zsh/.zshrc && rm $XDG_CACHE_HOME/ksycoca5*";
  };

}
