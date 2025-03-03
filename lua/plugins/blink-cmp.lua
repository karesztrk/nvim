return {
  "saghen/blink.cmp",
  dependencies = { "codeium.nvim", "saghen/blink.compat" },
  opts = function(_, opts)
    opts.enabled = function()
      -- Get the current buffer's filetype
      return not vim.tbl_contains({ "minifiles", "snacks_picker_input" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end
  end,
}
