local function project_root()
  local file = vim.api.nvim_buf_get_name(0)
  local dir = file ~= "" and vim.fs.dirname(file) or vim.uv.cwd()
  return Snacks.git.get_root(dir) or LazyVim.root()
end

local function scoped(picker)
  return function()
    Snacks.picker[picker]({ cwd = project_root() })
  end
end

return {
  "folke/snacks.nvim",
  keys = {
    { "<leader><space>", scoped("files"), desc = "Find Files (Project)" },
    { "<leader>ff", scoped("files"), desc = "Find Files (Project)" },
    { "<leader>/", scoped("grep"), desc = "Grep (Project)" },
    { "<leader>sg", scoped("grep"), desc = "Grep (Project)" },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word({ cwd = project_root() })
      end,
      mode = { "n", "x" },
      desc = "Word (Project)",
    },
  },
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
