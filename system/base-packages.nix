{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    wget
    bind #nslookup
    git
    nmap
    zsh-powerlevel10k
    nil # Nix language server
    docker-compose-language-service
    nextcloud-client
    xdg-ninja
    python3
    python311Packages.pip
    python311Packages.virtualenv
    distrobox
    hyfetch
    starfetch
    btop
    tmux
    tealdeer
    tree
    cifs-utils
  ];
}
