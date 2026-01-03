-- Y to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to the end of the line" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffers
vim.keymap.set("n", "<S-h>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-l>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete the current buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Navigation & pickers
vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader><space>", ":Pick files<CR>", { desc = "Find file" })
vim.keymap.set("n", "<leader>sg", ":Pick grep_live<CR>", { desc = "Find in files" })
vim.keymap.set("n", "<leader>,", ":Pick buffers<CR>", { desc = "Find in buffers" })
vim.keymap.set("n", "<leader>sR", ":Pick resume<CR>", { desc = "Find in buffers" })
vim.keymap.set('n', '<leader>fc', function()
  require('mini.pick').builtin.files({}, {
    source = {
      name = 'Config Files',
      cwd = vim.fn.stdpath('config')
    }
  })
end, { desc = 'Find NeoVim Config' })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e $MYVIMRC<CR>", { desc = "Edit config" })
vim.keymap.set("n", "<leader>rl", ":so $MYVIMRC<CR>", { desc = "Reload config" })

-- Fast util
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Fast <Esc>" })
vim.keymap.set("n", "nn", "<cmd>:w<cr>", { noremap = true, silent = true, desc = "Fast save" })
vim.keymap.set("n", "qq", "<cmd>q!<cr>", { desc = "Fast quit" })

-- Copy path
vim.keymap.set("n", "<leader>@", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = "Copy file path" })

-- Quickly source current file / execute Lua code
vim.keymap.set('n', '<leader>xx', '<Cmd>source %<CR>', { desc = 'Source current file' })
vim.keymap.set('n', '<leader>x', '<Cmd>:.lua<CR>', { desc = 'Lua: execute current line' })
vim.keymap.set('v', '<leader>x', '<Cmd>:lua<CR>', { desc = 'Lua: execute current selection' })

-- Terminal
vim.keymap.set("n", "<leader>gg", '<Cmd>:FloatingTerminal lazygit<CR>', { desc = "Open LazyGit" })
vim.keymap.set("n", "<leader>jj", '<Cmd>:FloatingTerminal lazyjj<CR>', { desc = "Open LazyJujutsu" })
vim.keymap.set("n", "<leader>dd", '<Cmd>:FloatingTerminal lazydocker<CR>', { desc = "Open LazyDocker" })
vim.keymap.set("n", "<leader>tt", '<Cmd>:FloatingTerminal<CR>', { desc = "Toggle floating terminal" })
vim.keymap.set("t", "qq", '<Cmd>:CloseFloatingTerminal<CR>', { desc = "Close floating terminal from terminal mode" })

-- Auto-close pairs
vim.keymap.set("i", "`", "``<left>")
vim.keymap.set("i", '"', '""<left>')
vim.keymap.set("i", "(", "()<left>")
vim.keymap.set("i", "[", "[]<left>")
vim.keymap.set("i", "{", "{}<left>")
vim.keymap.set("i", "<", "<><left>")

-- Commenting (add comment above/below current line)
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Keyword program (K for help on word under cursor)
vim.keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

vim.keymap.set("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

vim.keymap.set("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

-- Diagnostic & code action keymaps
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Code Rename" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover (alt)" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References", nowait = true })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Daily notes keymaps
local notes = require("notes")
vim.keymap.set("n", "<leader>fd", function()
  local current_line = vim.api.nvim_get_current_line()
  local date_line = current_line:match("%[%[%d+%-%d+%-%d+%-%w+%]%]") or ("[[" .. os.date("%Y-%m-%d-%A") .. "]]")
  notes.switch_to_daily_note(date_line)
end, { desc = "Go to or create daily note" })

vim.keymap.set("n", "<leader>fA", function()
  notes.create_next_n_days(1)
end, { desc = "Create next day's daily note from current file" })

vim.keymap.set("n", "<leader>fW", function()
  notes.create_next_n_days(7)
end, { desc = "Create next week's daily notes from current file" })


-- Formatting
local auto_format = true

vim.keymap.set("n", "<leader>uf", function()
  auto_format = not auto_format
  if auto_format then
    vim.cmd("FormatEnable")
  else
    vim.cmd("FormatDisable")
  end
end, { desc = "Toggle Autoformat" })

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true }, function(err, did_edit)
    if not err and did_edit then
      vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
    end
  end)
end, { desc = "Format buffer" })

-- Git
vim.keymap.set("n", "<leader>ghb", '<Cmd>:Gitsigns blame_line<CR>', { desc = "Blame the current line" })
vim.keymap.set("n", "<leader>ghr", '<Cmd>:Gitsigns reset_hunk<CR>', { desc = "Reset the current hunk" })
vim.keymap.set("n", "<leader>ghd", '<Cmd>:Gitsigns diffthis<CR>', { desc = "Diff this" })
vim.keymap.set("n", "<leader>ghp", '<Cmd>:Gitsigns preview_hunk_inline<CR>', { desc = "Preview this hunk" })
