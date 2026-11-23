-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- no mouse
vim.opt.mouse = ""

-- fallback startup state for colorscheme
vim.opt.background = "dark"
vim.g.gruvbox_material_background = "soft"

vim.opt.colorcolumn = "80"

vim.opt.wrap = true

-- yank to system clipboard, also over ssh/tmux (LazyVim skips this over ssh)
vim.opt.clipboard = "unnamedplus"

-- hard code root path; cwd() versions of key mappings already handle dynamic cwd
vim.g.code_dir = vim.uv.os_homedir() .. "/code"
vim.g.root_spec = {
  function()
    return vim.g.code_dir
  end,
}
