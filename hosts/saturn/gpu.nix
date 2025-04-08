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

  services.borgbackup.jobs."docker".repo = lib.mkForce "ssh://n4325hol@n4325hol.repo.borgbase.com/./repo";

  #virtualisation.docker.daemon.settings.ip = "192.168.80.124";
}
