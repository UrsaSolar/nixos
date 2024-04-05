{ config, pkgs, ... }:
{

  imports = [
    ./alias.nix
    ./zsh.nix
    ./fzf.nix
    ./yazi.nix
    ./nvim/nvim.nix
  ];


}
