{ pkgs, config, ... }:
{

  programs.zsh = {

    enable = true;
    dotDir = ".config/zsh"; # Relative to home, must be directly set

    autosuggestion = {
      enable = true;
      #strategy = [ "completion" ];   # [NOT IN STABLE 24.05]
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" ];
    };

    history = {
#      append = true;   # allow multiple sessions to share file [NOT IN STABLE 24.05]
      extended = true; # store timestamp
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      save = 10000;
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtra = builtins.readFile(./p10k.zsh);

  }; 

}


