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
  shellAliases = {
    # Shell shortcuts
    histoff = "set +o history";
    histon = "set -o history";
    hist = "cat $XDG_STATE_HOME/zsh/history | grep $@";
     # Fuzzy finder directory hopper
    jj = "clear && cd $(find ~/Software/ ~/.config/ ~/Documents -type d | fzf)";
    vv = "clear && vim $(find ~/Software/ ~/.config/ ~/Documents ~/Downloads ~/.vim ~/.bashrc -type f | fzf)";
    nxsync = "nextcloudcmd -n --path /Notes ~/Notes https://io.ursa.solar/";
    sshhosts = "grep '^Host' ~/.ssh/config | cut -d ' ' -f 2- | column";
  };
};

}
