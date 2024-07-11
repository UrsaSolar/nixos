{ config, pkgs, ... }:
{

  imports = [
    ./alias.nix
    ./bat.nix
    ./btop.nix
    ./fzf.nix
    ./nvim/nvim.nix
    ./yazi/yazi.nix
    ./zsh.nix
    # ./fish.nix
    #./ssh.nix
  ];


}
