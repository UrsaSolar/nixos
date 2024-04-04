{ config, pkgs, unstable, ... }:

{
  imports = [
    ./home/shell/zsh.nix
    ./home/shell/fzf.nix
    ./home/shell/yazi.nix
    ./home/shell/neovim.nix
  ];

  home.stateVersion = "23.11"; # Historical
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  home.packages = with pkgs; [ 
    zsh-powerlevel10k
  ];

  home.sessionVariables = {
    XDG_DATA_HOME="$HOME/.local/share";
    XDG_CONFIG_HOME="$HOME/.config";
    XDG_STATE_HOME="$HOME/.local/state";
    XDG_CACHE_HOME="$HOME/.cache";

    EDITOR = "vim";
  };

  
}
