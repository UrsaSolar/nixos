{ config, pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    extraConfig = ''colorscheme catppuccin-mocha'';
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      { plugin = lualine-nvim;
        type = "lua";
	config = builtins.readFile(./lualine-config.lua);
      }
    ];
  };

}
