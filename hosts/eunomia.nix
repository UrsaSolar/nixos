{ pkgs, ... }:

{

  imports = [
    ./eunomia-hardware.nix
    ../system/base-configuration.nix
    ../system/base-packages.nix
    ../system/bootloader.nix
    ../system/ssh.nix
    ../system/docker-rootful.nix
    ../system/servers.nix
    ../system/promtail.nix
  ];

  system.stateVersion = "24.05";
  networking.hostName = "eunomia";

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" ];
    shell = pkgs.zsh;
    linger = true;
  };

  # SSH Unlocking - https://wiki.nixos.org/w/index.php?title=Remote_disk_unlocking
  networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    postgresql_16
    sqlite
    kubernetes-helm
  ];

  # KUBERNETES TIME
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/cluster/k3s/docs/USAGE.md
  #services.k3s.enable = true;
  #services.k3s.role = "server";


}
