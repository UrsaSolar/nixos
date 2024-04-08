{ config, pkgs, ... }:
{

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh"; # Relative to home, must be directly set
    #histFile = "$XDG_STATE_HOME/zsh/zsh_history";
    #histSize = "10000";
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtra = builtins.readFile(./p10k.zsh);
  }; 

#  programs.starship = {
#    enable = true;
    # Configuration written to ~/.config/starship.toml
#    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
#    };
#  };
}


