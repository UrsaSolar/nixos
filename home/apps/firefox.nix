{ configs, pkgs, ... }:
{

  programs.firefox = {
    enable = true;
    profiles.solarbear = {
      id = 0;
      name = "solarbear";
      isDefault = true;
      userChrome = builtins.fileRead (./userChrome.css);
      search = {
        default = "DuckDuckGo";
        force = true;
      };
      settings ={};
    }; 
  };

}
