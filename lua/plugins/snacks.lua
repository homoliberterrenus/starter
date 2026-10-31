return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true, -- Set to true if you want dotfiles included
          ignored = false, -- Set to false so it respects .gitignore (true means ignore .gitignore)
        },
        explorer = {
          hidden = true,
          ignored = false, -- Set to false to respect .gitignore in explorer
        },
        grep = {
          hidden = true,
          ignored = false, -- Set to false to respect .gitignore in grep
        },
      },
    },
  },
}
