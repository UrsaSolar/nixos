{ pkgs, ... }:
{

  imports = [
    ./unfree.nix
  ];
  environment.systemPackages = with pkgs; [

    #terminal tools
    nmap
    p7zip
    unrar
    zsh-powerlevel10k
    tealdeer
    neovim
    xdg-ninja
    hyfetch
    lm_sensors
    jq

    # language servers for nvim
    nil # Nix
    nodePackages.yaml-language-server
    nodePackages.nodejs
    docker-compose-language-service

  ];
}
