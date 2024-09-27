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

}
