vim.pack.add({
  "https://github.com/nvim-mini/mini.splitjoin.git",
})

-- mini.splitjoin configuration
require("mini.splitjoin").setup({
    mappings = { toggle = "<leader>m", join = "<leader>j", split = "<leader>k" },
})
