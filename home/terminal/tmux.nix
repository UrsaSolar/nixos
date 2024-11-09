{ pkgs, ... }:
{

  programs.tmux = {
    enable = true;
    mouse = true;
    #enableFzf = true; ?
    sensibleOnTop = true;
    plugins = with pkgs; [ tmuxPlugins.cpu ];
    extraConfig = ''

      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux

    '';
    catppuccin.extraConfig = ''
      set -g @catppuccin_window_status_style "basic"
      set -g @catppuccin_status_modules_right "application cpu host"
    '';
  };

}
