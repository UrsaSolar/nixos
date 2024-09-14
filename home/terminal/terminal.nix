{ ... }:
{

  imports = [
    ./alias.nix
    ./btop.nix
    ./nvim/nvim.nix
    ./yazi/yazi.nix
    ./zsh.nix
  ];

  programs.bat = {
    enable = true;
  };
  programs.fzf = {
    enable = true;
  };
}
