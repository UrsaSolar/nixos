{ ... }:
{

  programs.tmux = {
    enable = true;
    mouse = true;
    #enableFzf = true; ?
    sensibleOnTop = true;
    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:Tc"
    '';
  };

}
