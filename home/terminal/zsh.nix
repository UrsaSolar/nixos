{ config, pkgs, ... }:
{

programs.zsh = {
  enable = true;
  dotDir = ".config/zsh";
  plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];
  initExtra = builtins.readFile(./p10k.zsh);
};

}
