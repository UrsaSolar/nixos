{ pkgs, ... }:
{

  programs.plasma = {
    enable = true;
    configFile.kcminputrc.Keyboard.NumLock.value = 0; # Enable numlock on boot
    #workspace = {
    #  clickItemTo = "select";
    #  lookAndFeel = "org.kde.breezedark.desktop";
    #  cursorTheme = "Default";
    #  iconTheme = "Papirus-Dark";
    #  colorScheme = "CatppuccinMochaFlamingo";
    #};
    #hotkeys.commands."launch-konsole" = {
    #  name = "Launch Konsole";
    #  key = "Meta+Alt+K";
    #  command = "konsole";
    #};
  };

  services.kdeconnect.enable = true;

  # fixes glitches and inconsistency
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaGreen;
    name = "catppuccin-mocha-green-cursors";
    size = 48;
  };

  home.packages = with pkgs; [
    catppuccin-kvantum
    strawberry
    kcalc
  ];

}
