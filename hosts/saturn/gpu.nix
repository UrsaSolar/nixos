{ pkgs, lib, ... }:

{

  imports = [
    ./gpu-hardware.nix
    ../../system/config/base.nix
    ../../system/config/docker.nix
    ../../system/gpu/nvidia.nix
    ../../system/pkgs/base.nix
    ../../system/users/server.nix
    ../../system/users/ssh.nix
    #../../system/promtail.nix
  ];

  networking.hostName = "saturn-gpu";

  #virtualisation.docker.daemon.settings.ip = "192.168.80.124";
}
