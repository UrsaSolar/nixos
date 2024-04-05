{ config, pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      colorscheme catppuccin-mocha
      nmap <F1> :Neotree toggle=true<CR>
    '';
    plugins = with pkgs.vimPlugins; [
      { plugin = neo-tree-nvim;
          type = "lua";
          config = builtins.readFile(./neotree-config.lua); }
      { plugin = lualine-nvim;
          type = "lua";
	  config = builtins.readFile(./lualine-config.lua); }
    catppuccin-nvim
    which-key-nvim
    ];
  };

}