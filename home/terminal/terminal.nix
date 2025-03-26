{ ... }:
{

  imports = [
    ./nvim/nvim.nix
    ./yazi.nix
    ./zsh/zsh.nix
  ];

  programs.bat.enable = true;
  services.ssh-agent.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
