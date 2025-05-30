return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
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
