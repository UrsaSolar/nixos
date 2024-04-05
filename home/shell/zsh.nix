{ config, pkgs, ... }:
{

programs.zsh = {
  enable = true;
  dotDir = ".config/zsh";
  plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];
#  initExtra = ''
#    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
#    source ~/.config/zsh/p10k.zsh
#  '';
  initExtra = builtins.readFile(./p10k.zsh);
#  shellAliases = {
    # Shell shortcuts
#    zrl = "source $XDG_CONFIG_HOME/zsh/.zshrc";
#    histoff = "set +o history";
#    histon = "set -o history";
#    hist = "cat $XDG_STATE_HOME/zsh/history | grep $@";
     # Fuzzy finder directory hopper
#    jj = "clear && cd $(find ~/Software/ ~/.config/ ~/Documents -type d | fzf)";
#    vv = "clear && nvim $(find ~/Software/ ~/.config/ ~/Documents ~/Downloads -type f | fzf)";
#    notesync = "nextcloudcmd -n --path /Notes ~/Notes https://io.ursa.solar/";
#    sshhosts = "grep '^Host' ~/.ssh/config | cut -d ' ' -f 2- | column";
    # NixOS shortcuts
#    hm-rebuild = "home-manager switch --flake $XDG_CONFIG_HOME/nixos/ && source $XDG_CONFIG_HOME/zsh/.zshrc";
#    nx-rebuild = "sudo nixos-rebuild switch --flake $XDG_CONFIG_HOME/nixos/";
#    cdnix = "cd $XDG_CONFIG_HOME/nixos/";
#  };
};

}
