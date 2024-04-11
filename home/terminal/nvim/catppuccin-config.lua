-- https://github.com/catppuccin/nvim
require("catppuccin").setup({

  flavour = "mocha",
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  integrations = {
    -- lualine: set in lualine-config.lua
    barbar = true,
    neotree = true,
    which_key = true,
    telescope = {
      enabled = true,
      -- style = "nvchad",
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
  },

})

vim.cmd.colorscheme "catppuccin"
