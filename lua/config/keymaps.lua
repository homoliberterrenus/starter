-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>wa", "<cmd>wall<CR>", { desc = "Save all buffers" })
vim.keymap.set("n", "<leader>qw", "<cmd>wall<CR><cmd>qall<CR>", { desc = "Save and quit all buffers" })
