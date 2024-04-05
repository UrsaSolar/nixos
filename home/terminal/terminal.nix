{ config, pkgs, ... }:
{

  imports = [
    ./alias.nix
    ./ssh.nix
    ./zsh.nix
    ./fzf.nix
    ./yazi.nix
    ./nvim/nvim.nix
  ];


}
