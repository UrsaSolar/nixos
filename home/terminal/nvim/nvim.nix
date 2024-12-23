{ pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      nmap <F1> :Neotree toggle reveal<CR>
      set tabstop=2                                         " format tabs sanely
      set shiftwidth=4
      set expandtab
      set ignorecase
      set smartcase
      nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>    " commands to allow easy buffer switching
      nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>
      autocmd FileType yaml set indentexpr=                 " prevents auto-indent on commenting in yaml
    '';
    #extraLuaConfig = builtins.readFile(./catppuccin-config.lua);
    plugins = with pkgs.vimPlugins; [

      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = builtins.readFile(./neotree-config.lua);
      }

      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile(./lualine-config.lua);
      }

      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = builtins.readFile(./indent-blankline.lua);
      }

      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile(./treesitter-config.lua);
      }

      {
        plugin = gruvbox-material-nvim;
        type = "lua";
        config = builtins.readFile(./gruvbox-config.lua);
      }

      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          require('lspconfig').nil_ls.setup{}
          require('lspconfig').docker_compose_language_service.setup{}
          require('lspconfig').yamlls.setup{}
        '';
      }

      #{ plugin = unstable.vimPlugins.transparent-nvim; type = "lua"; config = builtins.readFile(./transparent-config.lua); }

      which-key-nvim
      vim-nix
      barbar-nvim
      nvim-web-devicons # needed for barbar
      legendary-nvim
      telescope-nvim # recommended for legendary
      dressing-nvim
      cheatsheet-nvim
      #unstable.vimPlugins.transparent-nvim
      rainbow-delimiters-nvim

    ];
  
  };

}
