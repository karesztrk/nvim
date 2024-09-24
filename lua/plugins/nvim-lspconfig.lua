return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      -- inlay_hints = {
      --   enabled = false,
      -- },
    },
  },
}
