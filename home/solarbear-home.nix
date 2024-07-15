{ ... }:

{
  
  imports = [
    ./graphical.nix
    ./apps/gaming.nix
    ./terminal/ssh-home.nix
#    ./apps/emulation.nix
  ];

  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";

  home.shellAliases = {
    hm-rebuild = "home-manager switch --flake $NIXOSDIR && source $XDG_CONFIG_HOME/zsh/.zshrc && rm $XDG_CACHE_HOME/ksycoca5*";
  };

}
