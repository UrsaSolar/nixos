{ pkgs, ... }:
{
  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ]; # Required for zsh autocomplete
  programs.nix-ld.enable = true;
  
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
