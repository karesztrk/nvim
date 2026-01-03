-- autocmd
--------------------------------------------------------------------------------
-- Highlight when yanking
---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Terminal
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- Mini path copy
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

-- Transparency
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
    vim.cmd("highlight SignColumn ctermbg=NONE guibg=NONE")
  end,
})

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})


-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Formatting
vim.api.nvim_create_user_command("FormatDisable", function(opts)
  if opts.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
  vim.notify("Autoformat disabled" .. (opts.bang and " (buffer)" or " (global)"), vim.log.levels.INFO)
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
  vim.notify("Autoformat enabled", vim.log.levels.INFO)
end, { desc = "Re-enable autoformat-on-save" })
