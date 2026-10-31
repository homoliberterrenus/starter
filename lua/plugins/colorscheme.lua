return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000, -- ensure load first before other plugins
    config = function()
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },

  -- disable default colorscheme plugin
  { "folke/tokyonight.nvim", enabled = false },
}
