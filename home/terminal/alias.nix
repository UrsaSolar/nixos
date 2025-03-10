{ ... }:
{

 home.shellAliases = {
    
    # Shell shortcuts
    zrl = "source $XDG_CONFIG_HOME/zsh/.zshrc";
    histoff = "set +o history";
    histon = "set -o history";
    #hist = "cat $XDG_STATE_HOME/zsh/history | grep $@";
    
    # Fuzzy finder & directory hoppers
    jj = "clear && cd $(find ~/Software/ ~/.config/ ~/Documents -type d | fbat)";
    vv = "clear && nvim $(find ~/Software/ ~/.config/ ~/Documents ~/Downloads -type f | fbat)";
    fzbat = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    fzgrep = "grep --line-buffered --color=never -r \"\" * | fzf";

    # Replacements
    ls = "eza --icons=always";
    cat = "bat";
    catplain = "bat --style=plain";
    duf = "duf --hide special";
    
    # Other useful commands
    notesync = "nextcloudcmd -n --path /Notes ~/Notes https://io.ursa.solar/";
    sshhosts = "grep '^Host' ~/.ssh/config | cut -d ' ' -f 2- | column";
 
    # NixOS shortcuts
    #hm-rebuild = "home-manager switch --flake $NIXOSDIR && source $XDG_CONFIG_HOME/zsh/.zshrc && rm $XDG_CACHE_HOME/ksycoca5*";
    nx-rebuild = "sudo nixos-rebuild switch --flake $NIXOSDIR";
    nx-bootswitch = "sudo nixos-rebuild boot --flake $NIXOSDIR";
    nx-upchannel = "sudo nix-channel --update";
    nx-update = "git --git-dir=$NIXOSDIR/.git/ --work-tree=$NIXOSDIR pull && nix flake update --flake $NIXOSDIR && nx-upchannel && nix flake archive";
    nx-upgrade = "nx-update && nx-upchannel && nx-rebuild && hm-rebuild && gitflake";
    cdnix = "cd $NIXOSDIR";
    nx-vim = "vim $NIXOSDIR";

    # git shortcuts
    gitflake = "git add $NIXOSDIR/flake.lock && git commit -m \"Update flake.lock\" && git push";
    gitsweep = "git add * && git commit -m \"Sweep\" && git push";

  };
 

}
