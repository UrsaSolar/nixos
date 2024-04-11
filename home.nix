{ config, pkgs, ... }:

{
  imports = [
    ./home/terminal/terminal.nix
  ];

  home.stateVersion = "23.11"; # Historical
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
  catppuccin.flavour = "mocha";
  home.packages = with pkgs; [ 
    zsh-powerlevel10k
    nil # Language server
    tealdeer
    nextcloud-client
  ];

  xdg.enable = true;

  programs.btop = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.tmux = {
    enable = true;
    catppuccin.enable = true;
  };

  home.sessionVariables = {
    # XDG Specification Ride or Die
#    XDG_DATA_HOME="$HOME/.local/share";
#    XDG_CONFIG_HOME="$HOME/.config";
#    XDG_STATE_HOME="$HOME/.local/state";
#    XDG_CACHE_HOME="$HOME/.cache";
    # Dotfile cleanliness
    HISTFILE="$XDG_STATE_HOME/bash/history";
    LESSHISTFILE="$XDG_STATE_HOME/less/history";
    INPUTRC="$XDG_CONFIG_HOME/readline/inputrc";
    ANDROID_HOME="$XDG_DATA_HOME/android";
    CUDA_CACHE_PATH="XDG_CACHE_HOME/nv";
    GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
    WGETRC="$XDG_CONFIG_HOME/wgetrc";
    WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default";
    XINITRC="$XDG_CONFIG_HOME/X11/xinitrc";
    XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc";
    XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons";
    KDEHOME="$XDG_CONFIG_HOME/kde";
    NIXOSDIR="$XDG_CONFIG_HOME/nixos";
  };

  
}
