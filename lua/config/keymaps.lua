-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

-- Colemak remaps
-- vim.keymap.set({ "n", "v" }, "n", "j", { noremap = true, silent = true, desc = "Step down" })
-- vim.keymap.set({ "n", "v" }, "e", "k", { noremap = true, silent = true, desc = "Step up" })
-- vim.keymap.set({ "n", "v" }, "o", "l", { noremap = true, silent = true, desc = "Step right" })

vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })
vim.keymap.set("n", "<leader>;", "<cmd>Alpha<cr>", { desc = "Alpha" })
vim.keymap.set("n", "<leader>d", function()
  Util.float_term({ "lazydocker" })
end, { desc = "Lazydocker" })
