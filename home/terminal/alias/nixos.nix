{ ... }:{

 home.shellAliases = {
    #hm-rebuild = "home-manager switch --flake $NIXOSDIR && source $XDG_CONFIG_HOME/zsh/.zshrc && rm $XDG_CACHE_HOME/ksycoca5*";
    nx-rebuild = "sudo nixos-rebuild switch --flake $NIXOSDIR";
    nx-bootswitch = "sudo nixos-rebuild boot --flake $NIXOSDIR";
    nx-upchannel = "sudo nix-channel --update";
    nx-update = "git --git-dir=$NIXOSDIR/.git/ --work-tree=$NIXOSDIR pull && nix flake update --flake $NIXOSDIR && nx-upchannel && nix flake archive";
    nx-upgrade = "nx-update && nx-upchannel && nx-rebuild && hm-rebuild && gitflake";
    cdnix = "cd $NIXOSDIR";
    nx-vim = "vim $NIXOSDIR";
    gitflake = "git add $NIXOSDIR/flake.lock && git commit -m \"Update flake.lock\" && git push";
  };
}
