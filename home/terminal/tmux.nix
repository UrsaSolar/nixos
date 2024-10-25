{ ... }:
{

  programs.tmux = {
    enable = true;
    mouse = true;
    #enableFzf = true; ?
    sensibleOnTop = true;
    extraConfig = "run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux";
  };

}
