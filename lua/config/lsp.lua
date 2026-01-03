-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.
vim.lsp.enable({
  "astro",  -- @astrojs/language-server
  "biome",  -- @biomejs/biome
  "cssls",  -- vscode-langservers-extracted
  "eslint", -- vscode-langservers-extracted
  "html",   -- vscode-langservers-extracted
  "lua_ls", -- lua-language-server
  "vtsls"   -- @vtsls/language-server
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Built-in completion
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub("%b()", "") }
        end,
      })
    end

    -- Inlay hints
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHints) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentColor) then
      vim.lsp.document_color.enable(true, args.buf, {
        style = "background", -- 'background', 'foreground', or 'virtual'
      })
    end
  end,
})

vim.keymap.set("i", "<C-Space>", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if next(clients) ~= nil then
    vim.lsp.completion.get()
  else
    local key = vim.keycode("<C-x><C-n>")
    vim.api.nvim_feedkeys(key, "m", false)
  end
end, {})

-- Press <Tab> for the next autocomplete item
vim.keymap.set("i", "<Tab>", function()
  local key = vim.keycode("<Tab>")
  if vim.fn.pumvisible() == 1 then
    key = vim.keycode("<C-n>")
  end
  vim.api.nvim_feedkeys(key, "n", false)
end, {})

-- Press <Down> for the next autocomplete item
vim.keymap.set("i", "<Down>", function()
  local key = vim.keycode("<Down>")
  if vim.fn.pumvisible() == 1 then
    key = vim.keycode("<C-n>")
  end
  vim.api.nvim_feedkeys(key, "n", false)
end, {})

-- Press <Up> for the previous autocomplete item
vim.keymap.set("i", "<Up>", function()
  local key = vim.keycode("<Up>")
  if vim.fn.pumvisible() == 1 then
    key = vim.keycode("<C-p>")
  end
  vim.api.nvim_feedkeys(key, "n", false)
end, {})

-- Diagnostics
vim.diagnostic.config({
  -- keep underline & severity_sort on for quick scanning
  underline = true,
  severity_sort = true,
  update_in_insert = false, -- less flicker
  float = {
    border = "rounded",
    source = true,
  },
  virtual_text = false,
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
  -- signs = vim.g.have_nerd_font and {
  --   text = {
  --     [vim.diagnostic.severity.ERROR] = '󰅚 ',
  --     [vim.diagnostic.severity.WARN] = '󰀪 ',
  --     [vim.diagnostic.severity.INFO] = '󰋽 ',
  --     [vim.diagnostic.severity.HINT] = '󰌶 ',
  --   },
  -- } or {},
})
