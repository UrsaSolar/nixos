{ ... }:
{

  # Flake stuff
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.allowed-users = [ "@wheel" ];
  #Terminal stuff
  programs.zsh.enable = true;
  #environment.pathsToLink = [ "/share/zsh" ]; # Required for zsh autocomplete
  console.font = "Lat2-Terminus16";

  # Maintenance stuff
  nix.optimise.automatic = true; # Periodically optimize filesystem with hard links via systemd service
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  boot.loader.systemd-boot.configurationLimit = 10;
  services.fstrim.enable = true; # SSD cleanup

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
  
  networking.networkmanager.enable = true;

  services.journald.extraConfig = ''
    SystemMaxUse=500M
  '';

  security.polkit.extraConfig = ''
    polkit.addRule(function (action, subject) {
      if (
        subject.isInGroup("users") &&
        [
          "org.freedesktop.login1.reboot",
          "org.freedesktop.login1.reboot-multiple-sessions",
          "org.freedesktop.login1.power-off",
          "org.freedesktop.login1.power-off-multiple-sessions",
          "org.freedesktop.login1.suspend",
        ].indexOf(action.id) !== -1
      ) {
        return polkit.Result.YES;
      }
    });
  '';

}

