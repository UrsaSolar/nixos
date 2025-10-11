{ pkgs, ... }:
{

  hardware.keyboard.qmk.enable = true;

  # Pipewire with PulseAudio and Alsa support
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings.general = {
      enable = "Source,Sink,Media,Socket"; # Enable A2DP sink
      experimental = true; # Enables battery reporting
    };
  };
  programs.dconf.enable = true; # Needed for EasyEffects daemon
  
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  services.printing.enable = true;

  services.syncthing = {
    enable = true;
    user = "solarbear";
    dataDir = "/home/solarbear/Quicksync";
    configDir = "/home/solarbear/.config/syncthing";
  };

  environment.systemPackages = with pkgs; [
    corectrl
    firefox
    thunderbird
    ungoogled-chromium
    vlc
    #    jellyfin-media-player
    nextcloud-client
  ];

  fonts.packages = with pkgs; [
    iosevka
    nerd-fonts.terminess-ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

}
