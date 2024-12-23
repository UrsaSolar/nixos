{ ... }:
{

  imports = [
    ./alias.nix
    ./btop.nix
    ./nvim/nvim.nix
    ./tmux.nix
    ./yazi/yazi.nix
    ./zsh/zsh.nix
  ];

  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.btop.enable = true;
  programs.tmux.enable = true;
  services.ssh-agent.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

}
