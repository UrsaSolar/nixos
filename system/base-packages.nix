{ pkgs, ... }:
{

  imports = [
    ./unfree.nix
  ];
  environment.systemPackages = with pkgs; [

    #terminal tools
    killall
    wget
    bind #nslookup
    git
    nmap
    p7zip
    unrar
    zsh-powerlevel10k
    btop
    tmux
    tealdeer
    tree
    cifs-utils
    unzip
    openssl
    bat # cat replacement
    btop 
    fzf 
    yazi # file browser
    neovim
    eza # ls replacement
    duf # df replacement
    ncdu # ncurses disk usage TUI
    du-dust # du replacement
    gping # ping replacement
    jq # json query
    binutils # gnu binary tools (ld, strings, readelf)
    file # filetype guesser
    xdg-ninja
    hyfetch
    starfetch
    step-cli
    lm_sensors
    exfatprogs
    lsof
    dialog

    # language servers for nvim
    nil # Nix
    yaml-language-server
    docker-compose-language-service

    # other software
    nextcloud-client
    #python3
    #python311Packages.pip
    #python311Packages.virtualenv
   
  ];
}
