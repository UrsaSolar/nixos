{ pkgs, config, ... }:
{

  programs.plasma = {
    enable = true;
      workspace ={
        clickItemTo = "select";
        lookAndFeel = "org.kde.breezedark.desktop";
        cursorTheme = "Default";
        iconTheme = "Papirus-Dark";
      };
      hotkeys.commands."launch-konsole" = {
        name = "Launch Konsole";
        key = "Meta+Alt+K";
        command = "konsole";
      };
  };



}
