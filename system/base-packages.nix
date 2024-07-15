{ pkgs, ... }:
{

  imports = [
    ./unfree.nix
  ];
  environment.systemPackages = with pkgs; [
    wget
    bind #nslookup
    git
    nmap
    p7zip
    unrar
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
    unzip
    openssl
    bat
    btop
    fzf
    yazi
    neovim
    eza
    duf
    du-dust
    gping
    jq
  ];
}
