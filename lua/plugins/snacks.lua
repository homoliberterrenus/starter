local function project_root()
  local file = vim.api.nvim_buf_get_name(0)
  local dir = file ~= "" and vim.fs.dirname(file) or vim.uv.cwd()
  return Snacks.git.get_root(dir) or LazyVim.root()
end

local function code_root()
  return vim.g.code_dir
end

local function pick(picker, root, opts)
  return function()
    Snacks.picker[picker](vim.tbl_extend("force", { cwd = root() }, opts and opts(root()) or {}))
  end
end

local recent = function(dir)
  return { filter = { cwd = dir } }
end

local function map(lhs, picker, root, desc, opts)
  return { lhs, pick(picker, root, opts), mode = { "n", "x" }, desc = desc }
end

return {
  "folke/snacks.nvim",
  keys = {
    map("<leader><space>", "files", project_root, "Find Files (Project)"),
    map("<leader>ff", "files", project_root, "Find Files (Project)"),
    map("<leader>fF", "files", code_root, "Find Files (Code)"),
    map("<leader>sg", "grep", project_root, "Grep (Project)"),
    map("<leader>/", "grep", project_root, "Grep (Project)"),
    map("<leader>sG", "grep", code_root, "Grep (Code)"),
    map("<leader>sw", "grep_word", project_root, "Word (Project)"),
    map("<leader>sW", "grep_word", code_root, "Word (Code)"),
    map("<leader>fr", "recent", project_root, "Recent (Project)", recent),
    map("<leader>fR", "recent", code_root, "Recent (Code)", recent),
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
