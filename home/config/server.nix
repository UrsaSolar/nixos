{ ... }:

{
  
  home.username = "solarbear";
  home.homeDirectory = "/home/solarbear";

  home.shellAliases = {
    hm-rebuild = "home-manager switch --flake $NIXOSDIR#solarbear-server && source $XDG_CONFIG_HOME/.bashrc";
  };

}
