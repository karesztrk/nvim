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
        virtual_lines = {
          current_line = true,
        },
      },
    },
  },
}
