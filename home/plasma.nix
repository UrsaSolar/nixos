{ pkgs, config, ... }:
{

  programs.plasma = {
    enable = true;
    configFile.kcminputrc.Keyboard.NumLock.value = 0; # Enable numlock on boot
    workspace ={
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      cursorTheme = "Default";
      iconTheme = "Papirus-Dark";
      colorScheme = "CatppuccinMochaFlamingo";
    };
    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };
  };

  home.packages = with pkgs; [
    catppuccin-kvantum
  ];

}
