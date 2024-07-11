# terra.nix

{ config, pkgs, unstable, ... }:
{

  imports = [
    ./terra-hardware.nix
    ../system/graphical.nix
    ../system/plasma.nix
    ../system/gaming.nix
    #../system/emulation.nix
  ];

  system.stateVersion = "23.11"; # Historical reference
  nixpkgs.config.allowUnfree = true; #Allow unfree packages
  networking.hostName = "terra";

  users.users.solarbear = {
    isNormalUser = true;
    description = "Solar Bear";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    shell = pkgs.zsh;
    #openssh.authorizedKeys.keys = [  # Enable after fixing accounts!!
      #"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCKhaScuhiDCTHvYRUF835VN+geeMrxFaWA0Oe+UukSOrOW3BRvVTZKirUbt2ohSTIom/ij3tKC+3TcHj7i1BJ3I5BgEYd3PitiYfhdK1LjjKGJMIe4sgYo1B7AQARSvQ8MPoPYL7RpEx553m2DRo/jGx8rj6otyRw3iNArIkpB1g2meY+/Hfn42T9Lyvsa+DTuWVyE5W8unmYJVn8qFjJ0W8p5TrlOPK1UEM4eO/I7C9Lsfb6E/s2MFQRwHD0I6K4Alyaux2P/JHygD1WKafpzh7Xo8dTWmXUmEMIDnOwndg4idZeg5vJRIuKe/IT8vu7on4PG37S/jYVbZnEBo0BK0ehRYc+PD6VWSq3EXGW2jPFNx5e4XpIEsr3KE0TxE4YethmLH1bmwP/g8Zomu5MZx3Eyp5DGy+2xGTL9mbjzaqoxNa3cVKl9hW+3mAEkFiLtiXrRTCKKnEv3OKX7Yctn2Mkb3KsxjyZTN2UbVxa/3e4v2prwz03vg/+KX2x/bws= root@mercury"
    #];
 };

  services.openssh.enable = true;
  programs.adb.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport32Bit = true;
  hardware.ckb-next.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

}
