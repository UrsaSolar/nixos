{ unstable, ... }: 
{

  programs.yazi = {
    enable = true;
    package = unstable.yazi;
    enableZshIntegration = true;
    settings = {
      manager = {
        ratio = [ 2 3 4 ];
        linemode = "mtime";
        sort_by = "natural";
      }; 
    };
  };

  # Removed. Also, I don't remember what it did.
#  home.file = {
#    ".config/yazi/init.lua" = {
#      text = builtins.readFile(./yazi-init.lua);
#    };
#  };

}
