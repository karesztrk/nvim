return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["javascript"] = { "prettierd", "biome" },
      ["css"] = { "biome" },
      ["scss"] = { "prettierd" },
      ["typescriptreact"] = { "prettierd" },
    },
    formatters = {
      prettierd = {
        condition = function(self, ctx)
          -- Dont use prettier under this project
          return string.find(ctx.filename, "designhub") == nil
        end,
      },
    },
  },
}
