{ pkgs, unstable, ... }:
{
  
  # Pipewire with PulseAudio and Alsa support
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    extraConfig = {
      pipewire."92-low-latency" = {
        context.properties = {
          default.clock.rate = 48000;
          default.clock.quantum = 32;
          default.clock.min-quantum = 32;
          default.clock.max-quantum = 32;
        };
      };
      pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/48000";
              pulse.default.req = "32/48000";
              pulse.max.req = "32/48000";
              pulse.min.quantum = "32/48000";
              pulse.max.quantum = "32/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "32/48000";
          resample.quality = 1;
        };
      };
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
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
    corectrl
    firefox
    thunderbird
    ungoogled-chromium
    vlc
    jellyfin-media-player
    unstable.amarok
    nextcloud-client
    libreoffice
    anki
    virt-manager
  ];

  fonts.packages = with pkgs; [
    iosevka
    terminus-nerdfont
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

}
