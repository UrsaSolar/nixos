{ pkgs, ... }:
{

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-soft.yaml";
    targets = {
      nixvim = {
        enable = false;
        #transparentBackground.main = true;
      };
    };
  };

}
