vim.pack.add({
  "https://github.com/stevearc/conform.nvim.git",
})

-- Lightweight yet powerful formatter plugin for Neovim
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "biome", "prettier", stop_after_first = true },
    markdown = { "prettier" },
    javascript = { "biome", "prettier", stop_after_first = true },
    typescript = { "biome", "prettier", stop_after_first = true },
    javascriptreact = { "biome", "prettier", stop_after_first = true },
    typescriptreact = { "biome", "prettier", stop_after_first = true },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "html", "prettier", stop_after_first = true },
    rust = { "rustfmt", lsp_format = "fallback" },
    astro = { "biome", "prettier", stop_after_first = true },
  },
  formatters = {
    biome = { require_cwd = true },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = function(bufnr)
    local ignore_filetypes = { "sql", "yaml", "yml" }
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
      return
    end
    return { timeout_ms = 5000, lsp_format = "fallback" }
  end,
})
