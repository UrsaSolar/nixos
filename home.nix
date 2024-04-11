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
    xdg-ninja
  ];

  xdg.enable = true; # Reference with ${config.xdg.objectHome}

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
    HISTFILE="${config.xdg.stateHome}/zsh/history";
    LESSHISTFILE="${config.xdg.stateHome}/less/history";
    INPUTRC="${config.xdg.configHome}/readline/inputrc";
    ANDROID_HOME="${config.xdg.dataHome}/android";
    CUDA_CACHE_PATH="${config.xdg.cacheHome}/nv";
    GTK2_RC_FILES="${config.xdg.configHome}/gtk-2.0/gtkrc";
    WGETRC="${config.xdg.configHome}/wgetrc";
    WINEPREFIX="${config.xdg.dataHome}/wineprefixes/default";
    XINITRC="${config.xdg.configHome}/X11/xinitrc";
    XSERVERRC="${config.xdg.configHome}/X11/xserverrc";
    XCURSOR_PATH="/usr/share/icons:${config.xdg.dataHome}/icons";
    KDEHOME="${config.xdg.configHome}/kde";
    NIXOSDIR="${config.xdg.configHome}/nixos";
  };

  
}
