return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "prettierd")
    table.insert(opts.ensure_installed, "js-debug-adapter")
    table.insert(opts.ensure_installed, "harper-ls")
  end,
}
