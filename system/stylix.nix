{ pkgs, ... }:
{

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    targets = {
      nixvim = {
        enable = false;
        #transparentBackground.main = true;
      };
    };
  };

}
