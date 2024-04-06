{ pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      colorscheme catppuccin-mocha
      nmap <F1> :Neotree toggle reveal<CR>
      set tabstop=2
      set shiftwidth=4
      set expandtab
      set ignorecase
      set smartcase
    '';
    extraLuaConfig = ''
      require'lspconfig'.nil_ls.setup{}
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
      vim-nix
      nvim-lspconfig
      barbar-nvim
      nvim-web-devicons # needed for barbar
    ];
  };

}
