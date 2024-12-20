{ config, ... }:

{
  imports = [
    ./home/terminal/terminal.nix
  ];

  home.stateVersion = "23.11"; # Historical
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
  #catppuccin.flavor = "mocha";
  #catppuccin.enable = true;
  xdg.enable = true; # Reference with ${config.xdg.objectHome}

  nix.gc = {
    automatic = true;
    frequency = "daily";
  };

  home.sessionVariables = {
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
    #NIX_PATH="${config.xdg.configHome}/nixos";
  };

  
}
