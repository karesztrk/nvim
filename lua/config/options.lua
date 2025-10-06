-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_scroll = false

vim.g.ai_cmp = true

vim.g.lazyvim_prettier_needs_config = true

-- Remove intro message (show welcome screen)
vim.opt.shortmess:remove("I")

-- Set to false to disable auto format
vim.g.lazyvim_eslint_auto_format = false

-- Width of the left status column
vim.opt.numberwidth = 4
-- I prefer the default status column
vim.opt.statuscolumn = ""
