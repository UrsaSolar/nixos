{ ... }:
{

  imports = [
    ./alias.nix
    ./btop.nix
    ./nvim/nvim.nix
    ./starship.nix
    ./tmux.nix
    ./yazi/yazi.nix
    ./zsh.nix
  ];

  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.btop.enable = true;
  programs.tmux.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

}
