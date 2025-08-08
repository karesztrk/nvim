-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
    vim.cmd("highlight SignColumn ctermbg=NONE guibg=NONE")
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("User", {
  -- Updated pattern to match what Echasnovski has in the documentation
  -- https://github.com/echasnovski/mini.nvim/blob/c6eede272cfdb9b804e40dc43bb9bff53f38ed8a/doc/mini-files.txt#L508-L529
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Import 'mini.files' module
    local mini_files = require("mini.files")

    -- Copy the current file or directory path (relative to home) to clipboard
    vim.keymap.set("n", "@", function()
      -- Get the current entry (file or directory)
      local curr_entry = mini_files.get_fs_entry()
      if curr_entry then
        -- Convert path to be relative to home directory
        local home_dir = vim.fn.expand("~")
        local relative_path = curr_entry.path:gsub("^" .. home_dir, "~")
        vim.fn.setreg("+", relative_path) -- Copy the relative path to the clipboard register
        vim.notify("Path copied to clipboard", vim.log.levels.INFO)
      else
        vim.notify("No file or directory selected", vim.log.levels.WARN)
      end
    end, { buffer = buf_id, noremap = true, silent = true, desc = "[P]Copy relative path to clipboard" })
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
