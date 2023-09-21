return {
  "neovim/nvim-lspconfig",
  dependencies = { "jose-elias-alvarez/typescript.nvim" },
  opts = {
    diagnostics = {
      -- Disable errors popping up
      virtual_text = false,
    },
    -- make sure mason installs the server
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        keys = {
          { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
          { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
        },
        settings = {
          typescript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          javascript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
        },
      },
      eslint = {
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectory = { mode = "auto" },
        },
      },
    },
    setup = {
      tsserver = function(_, opts)
        require("typescript").setup({ server = opts })
        return true
      end,
      eslint = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = function(event)
            if not require("lazyvim.plugins.lsp.format").enabled() then
              -- exit early if autoformat is not enabled
              return
            end

            local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
            if client then
              local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
              if #diag > 0 then
                vim.cmd("EslintFixAll")
              end
            end
          end,
        })
      end,
    },
  },
}
