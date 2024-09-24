-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })
vim.keymap.set("n", "nn", "<cmd>:w<cr>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("n", "<leader>;", "<cmd>Dashboard<cr>", { desc = "Dashboard" })
vim.keymap.set("n", "<leader>d", function()
  Util.terminal.open({ "lazydocker" })
end, { desc = "Lazydocker" })
vim.keymap.set("n", "Y", "y$", { desc = "Yank to the end of the line" })
vim.keymap.set("n", "qq", "<cmd>q!<cr>", { desc = "Fast quit" })
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, { desc = "Open Undo tree" })

vim.keymap.set(
  "n",
  "<leader>hg",
  ":SynGroup()<CR>",
  { noremap = true, silent = true, desc = "Print the current highlight group" }
)
