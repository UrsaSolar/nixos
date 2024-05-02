{ config, pkgs, unstable, ... }:
{

  # Plasma Desktop
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.plasma5.bigscreen.enable = true;
  programs.dconf.enable = true; # Fix for Firefox not seeing mouse cursor settings; https://github.com/NixOS/nixpkgs/issues/207339#issuecomment-1747101887
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.autoNumlock = true;
  #services.xserver.displayManager.sddm.theme = "elegant-sddm";
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Pipewire with PulseAudio and Alsa support
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    sddm-kcm # SDDM config module
    xdg-desktop-portal
    xdg-desktop-portal-kde
    plasma-browser-integration
    catppuccin-papirus-folders
    breeze-gtk
    breeze-icons
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
    kate
    firefox
    thunderbird
    ungoogled-chromium
    vlc
    iosevka

  ];



}
