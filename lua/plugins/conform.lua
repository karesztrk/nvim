return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["html"] = { "prettier" },
    },
    formatters = {
      prettier = {
        condition = function(self, ctx)
          -- Dont use prettier under this project
          return string.find(ctx.filename, "designhub") == nil
        end,
      },
    },
  },
}
