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
local function projects_dir()
  local home = vim.uv.os_homedir()
  if vim.fn.executable("xdg-user-dir") == 0 then
    return home
  end
  local dir = vim.trim(vim.fn.system({ "xdg-user-dir", "PROJECTS" }))
  if vim.v.shell_error ~= 0 or dir == "" then
    return home
  end
  return dir
end

vim.g.code_dir = projects_dir()
vim.g.root_spec = {
  function()
    return vim.g.code_dir
  end,
}
