{ ... }: 
{

  programs.yazi = {
    enable = true;
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
