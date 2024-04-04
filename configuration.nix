# Configuration.nix

{ config, pkgs, ... }:
{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.allowed-users = [ "@wheel" ];
  console.font = "Lat2-Terminus16";
  programs.zsh.enable = true;
  networking.networkmanager.enable = true;

  services.openssh.settings = { 
    PasswordAuthentication = false;
    PermitRootLogin = "no";
    PrintLastLog = false;
    PrintMotd = true;
  };

  # Timezone and localization
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    bind #nslookup
    git
  ];

 

 
}

