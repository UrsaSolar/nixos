{ ... }:
{

  programs.tmux = {
    enable = true;
    mouse = true;
    enableFzf = true;
    enableSensible = true;
    extraConfig = "run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux";
  };

}
