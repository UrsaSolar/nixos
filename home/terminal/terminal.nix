{ config, pkgs, ... }:
{

  imports = [
    ./alias.nix
    ./ssh.nix
    ./btop.nix
    ./zsh.nix
    ./fzf.nix
    ./yazi.nix
    ./nvim/nvim.nix
    ./bat.nix
#    ./fish.nix
  ];


}
