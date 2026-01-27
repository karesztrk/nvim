vim.pack.add({
  "https://github.com/nvim-mini/mini.files.git",
})

-- mini.files configuration
require("mini.files").setup({
  mappings = {
    go_in = "<CR>", -- Map both Enter and L to enter directories or open files
    go_in_plus = "L",
    go_out = "-",
    go_out_plus = "H",
  },
  options = {
    use_as_default_explorer = true,
  },
})
