vim.pack.add({
  "https://github.com/nvim-mini/mini.pick.git",
})

-- mini.pick configuration
require("mini.pick").setup({
  mappings = {
    toggle_info    = '<C-k>',
    toggle_preview = '<C-p>',
    move_down      = '<Tab>',
    move_up        = '<S-Tab>',
  }
})
