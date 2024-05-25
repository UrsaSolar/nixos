{ configs, pkgs, ... }:
{

  programs.firefox = {
    enable = true;
    profiles.solarbear = {
      id = 0;
      name = "solarbear";
      isDefault = true;
      userChrome = builtins.readFile(./firefox-userChrome.css);
      #search = {
      #  default = "Kagi";
      #  force = true;
      #};
      settings ={
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "widget.use-xdg-desktop-portal.settings" = 1;
        "widget.use-xdg-desktop-portal.open-uri" = 1;
      };
    }; 
  };

}
