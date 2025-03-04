return {
  "Exafunction/codeium.vim",
  config = function()
    require("codeium").setup({
      -- Optionally disable cmp source if using virtual text only
      enable_cmp_source = vim.g.ai_cmp,
      virtual_text = {
        enabled = not vim.g.ai_cmp,
        key_bindings = {
          accept = false,
          next = "<A-,>",
          prev = "<A-.>",
        },
      },
    })
  end,
}
