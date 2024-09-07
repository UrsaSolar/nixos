{ pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      nmap <F1> :Neotree toggle reveal<CR>
      set tabstop=2
      set shiftwidth=4
      set expandtab
      set ignorecase
      set smartcase
      nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
      nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>
    '';
    #extraLuaConfig = builtins.readFile(./catppuccin-config.lua);
    plugins = with pkgs.vimPlugins; [

      { plugin = neo-tree-nvim;
          type = "lua";
          config = builtins.readFile(./neotree-config.lua); }
      { plugin = lualine-nvim;
          type = "lua";
          config = builtins.readFile(./lualine-config.lua); }
#      { plugin = unstable.vimPlugins.transparent-nvim;
#          type = "lua";
#          config = builtins.readFile(./transparent-config.lua); }
      { plugin = nvim-lspconfig;
          type = "lua";
          config = ''
            require('lspconfig').nil_ls.setup{}
            require('lspconfig').docker_compose_language_service.setup{}
            require('lspconfig').yamlls.setup{}
          '';
      }

      #catppuccin-nvim # currently provided by another systemwide package!
      which-key-nvim
      vim-nix
      #nvim-lspconfig
      barbar-nvim
      nvim-web-devicons # needed for barbar
      legendary-nvim
      telescope-nvim # recommended for legendary
      dressing-nvim
#      unstable.vimPlugins.transparent-nvim

    ];
  
  };

}
