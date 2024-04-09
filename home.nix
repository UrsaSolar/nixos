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
    HISTFILE="${config.home.sessionVariables.XDG_STATE_HOME}/bash/history";
    LESSHISTFILE="${config.home.sessionVariables.XDG_STATE_HOME}/less/history";
    INPUTRC="${config.home.sessionVariables.XDG_CONFIG_HOME}/readline/inputrc";
    ANDROID_HOME="${config.home.sessionVariables.XDG_DATA_HOME}/android";
    CUDA_CACHE_PATH="${config.home.sessionVariables.XDG_CACHE_HOME}/nv";
    GTK2_RC_FILES="${config.home.sessionVariables.XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
    WGETRC="${config.home.sessionVariables.XDG_CONFIG_HOME}/wgetrc";
    WINEPREFIX="${config.home.sessionVariables.XDG_DATA_HOME}/wineprefixes/default";
    XINITRC="${config.home.sessionVariables.XDG_CONFIG_HOME}/X11/xinitrc";
    XSERVERRC="${config.home.sessionVariables.XDG_CONFIG_HOME}/X11/xserverrc";
    XCURSOR_PATH="/usr/share/icons:${config.home.sessionVariables.XDG_DATA_HOME}/icons";
    KDEHOME="${config.home.sessionVariables.XDG_CONFIG_HOME}/kde";
    NIXOSDIR="${config.home.sessionVariables.XDG_CONFIG_HOME}/nixos";
  };

  
}
