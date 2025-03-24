{ pkgs, ... }:
{

  imports = [
    ./unfree.nix
  ];
  environment.systemPackages = with pkgs; [

    #terminal tools
    wget
    bind #nslookup
    git
    btop
    tmux
    cifs-utils
    unzip
    openssl
    nano
    fzf
    tree
    yazi # file browser
    bat # cat replacement
    eza # ls replacement
    duf # df replacement
    ncdu # ncurses disk usage TUI
    du-dust # du replacement
    gping # ping replacement

  ];
}
