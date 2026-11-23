-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { desc = "<Esc>" })
vim.keymap.set("i", "Jk", "<Esc>", { desc = "<Esc>" })
vim.keymap.set("i", "jK", "<Esc>", { desc = "<Esc>" })
vim.keymap.set("i", "JK", "<Esc>", { desc = "<Esc>" })

vim.keymap.set("n", "<leader>wb", "<cmd>w<CR>", { desc = "Save buffer" }) -- write "buffer"
vim.keymap.set("n", "<leader>wf", "<cmd>w<CR>", { desc = "Save buffer" }) -- write "file"
vim.keymap.set("n", "<leader>wa", "<cmd>wall<CR>", { desc = "Save all buffers" }) -- write "all"
vim.keymap.set("n", "<leader>ww", "<cmd>wall<CR>", { desc = "Save all buffers" }) -- muscle memory
vim.keymap.set("n", "<leader>qw", "<cmd>wall<CR><cmd>qall<CR>", { desc = "Save and quit all buffers" })

vim.keymap.set("n", "<leader>pf", "<cmd>put =expand('%:p')<CR>", { desc = "Put full file path" })

-- `:w !sudo tee %` can't prompt for a password in nvim; ask for it here instead
local function sudo_write()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return vim.notify("Buffer has no file name", vim.log.levels.ERROR)
  end

  local password = ""
  if vim.system({ "sudo", "-n", "true" }):wait().code ~= 0 then
    password = vim.fn.inputsecret("[sudo] password: ")
    if password == "" then
      return
    end
  end

  local tmp = vim.fn.tempname()
  vim.cmd("keepalt silent write! " .. vim.fn.fnameescape(tmp))
  local result = vim.system({ "sudo", "-S", "-p", "", "cp", tmp, file }, { stdin = password .. "\n" }):wait()
  os.remove(tmp)

  if result.code ~= 0 then
    return vim.notify(vim.trim(result.stderr), vim.log.levels.ERROR, { title = "Sudo write" })
  end
  vim.bo.modified = false
  vim.notify("Wrote " .. file, vim.log.levels.INFO, { title = "Sudo write" })
end

vim.keymap.set("n", "<leader>w!", sudo_write, { desc = "Save buffer with sudo" })

-- lazygit to open at current dir
vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Lazygit (current file)" })

-- toggle colorscheme
local colorschemes = {
  { mode = "light", contrast = "soft", name = "Light" },
  { mode = "light", contrast = "hard", name = "Extra Light" },
  { mode = "dark", contrast = "soft", name = "Dark" },
  { mode = "dark", contrast = "hard", name = "Extra Dark" },
}

vim.keymap.set("n", "<leader>ux", function()
  -- get current state
  local current_mode = vim.opt.background:get()
  local current_contrast = vim.g.gruvbox_material_background or "soft"

  -- find current colorscheme
  local current_index = 1
  for i, cs in ipairs(colorschemes) do
    if cs.mode == current_mode and cs.contrast == current_contrast then
      current_index = i
      break
    end
  end

  -- cycle to next colorscheme
  local next_index = (current_index % #colorschemes) + 1
  local target_cs = colorschemes[next_index]

  -- apply new colorscheme
  vim.opt.background = target_cs.mode
  vim.g.gruvbox_material_background = target_cs.contrast
  vim.cmd.colorscheme("gruvbox-material")

  -- inform user
  vim.notify("Switched to " .. target_cs.name, vim.log.levels.INFO, { title = "Colorscheme" })
end, { desc = "Cycle colorschemes" })

vim.keymap.set("n", "<leader>mm", function()
  require("render-markdown").toggle()
end, { desc = "Toggle markdown rendering" })
