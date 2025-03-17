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
      servers = {
        harper_ls = {
          enabled = true,
          filetypes = {
            "c",
            "cpp",
            "cs",
            "gitcommit",
            "go",
            "html",
            "java",
            "javascript",
            "lua",
            "markdown",
            "nix",
            "python",
            "ruby",
            "rust",
            "swift",
            "toml",
            "typescript",
            "typescriptreact",
            "haskell",
            "cmake",
            "typst",
            "php",
            "dart",
          },
          settings = {
            ["harper-ls"] = {
              linters = {
                SentenceCapitalization = false,
                SpellCheck = false,
              },
            },
          },
        },
      },
    },
  },
}
