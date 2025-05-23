{ pkgs, ... }: {

   # Plasma Desktop
   #services.xserver.enable = true; # No longer needed?
   services.desktopManager.plasma6.enable = true;
   programs.dconf.enable = true; # Fix for Firefox not seeing mouse cursor settings; https://github.com/NixOS/nixpkgs/issues/207339#issuecomment-1747101887
   services.displayManager.sddm = {
     enable = true;
     wayland.enable = true;
     autoNumlock = true;
     theme = "catppuccin-mocha";
   };
   # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;
   # Configure keymap in X11
   services.xserver.xkb.layout = "us";
   # Enable geolocation for sunrise/sunset night light tracking
   services.geoclue2.enable = true;
   environment.systemPackages = with pkgs; [
     kdePackages.sddm-kcm # SDDM config module
     kdePackages.bluedevil
     kdePackages.kdialog
     where-is-my-sddm-theme
     catppuccin-sddm
     catppuccin-sddm-corners
     sigil
     kdePackages.kate
     #kdePackages.kwrite
     kdePackages.kdenlive
     xdg-desktop-portal
     kdePackages.xdg-desktop-portal-kde
     kdePackages.plasma-browser-integration
     catppuccin-papirus-folders
     kdePackages.breeze
     kdePackages.breeze-gtk
     kdePackages.breeze-icons
     catppuccin-kvantum
     kdePackages.kcalc
     kdePackages.discover
     appimage-run
     vlc
     kdePackages.filelight
     wine-staging
     gimp
     kdePackages.partitionmanager
   ];

   environment.plasma6.excludePackages = with pkgs.kdePackages; [
     elisa
   ];

   # Run appimages directly with appimage-run
   programs.appimage = {
     enable = true;
     binfmt = true;
   };
}
