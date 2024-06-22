{ pkgs, config, ... }: {

 # Plasma Desktop
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.desktopManager.plasma5.bigscreen.enable = true;
  programs.dconf.enable = true; # Fix for Firefox not seeing mouse cursor settings; https://github.com/NixOS/nixpkgs/issues/207339#issuecomment-1747101887
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  #services.xserver.displayManager.sddm.theme = "elegant-sddm";
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
 
  environment.systemPackages = with pkgs; [
    sddm-kcm # SDDM config module
    kate
    #kwrite
    xdg-desktop-portal
    xdg-desktop-portal-kde
    plasma-browser-integration
    catppuccin-papirus-folders
    breeze-gtk
    breeze-icons
    catppuccin-kvantum
    strawberry
    kcalc
    discover
    bluedevil
  ];
}
