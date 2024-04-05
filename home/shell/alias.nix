{ config, pkgs, ... }:
{

 home.shellAliases = {
    # Shell shortcuts
    zrl = "source $XDG_CONFIG_HOME/zsh/.zshrc";
    histoff = "set +o history";
    histon = "set -o history";
    hist = "cat $XDG_STATE_HOME/zsh/history | grep $@";
     # Fuzzy finder directory hopper
    jj = "clear && cd $(find ~/Software/ ~/.config/ ~/Documents -type d | fzf)";
    vv = "clear && nvim $(find ~/Software/ ~/.config/ ~/Documents ~/Downloads -type f | fzf)";
    notesync = "nextcloudcmd -n --path /Notes ~/Notes https://io.ursa.solar/";
    sshhosts = "grep '^Host' ~/.ssh/config | cut -d ' ' -f 2- | column";
    # NixOS shortcuts
    hm-rebuild = "home-manager switch --flake $XDG_CONFIG_HOME/nixos/ && source $XDG_CONFIG_HOME/zsh/.zshrc";
    nx-rebuild = "sudo nixos-rebuild switch --flake $XDG_CONFIG_HOME/nixos/";
    cdnix = "cd $XDG_CONFIG_HOME/nixos/";
  };
 

}
