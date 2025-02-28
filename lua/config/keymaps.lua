-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })
vim.keymap.set("n", "nn", "<cmd>:w<cr>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("n", "<leader>;", ":lua Snacks.dashboard()<cr>", { desc = "Dashboard" })
vim.keymap.set("n", "<leader>d", function()
  Snacks.terminal.open({ "lazydocker" })
end, { desc = "Lazydocker" })
vim.keymap.set("n", "Y", "y$", { desc = "Yank to the end of the line" })
vim.keymap.set("n", "qq", "<cmd>q!<cr>", { desc = "Fast quit" })
vim.keymap.set("n", "<leader>rt", function()
  Snacks.terminal(nil, { win = { relative = "editor", position = "right" } })
end, { desc = "Open right terminal" })
vim.keymap.set({ "t", "n" }, "<C-f>", "<cmd>close<cr>", { desc = "Hide Terminal" })
vim.keymap.set("n", "<leader>e", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "Open right terminal" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
