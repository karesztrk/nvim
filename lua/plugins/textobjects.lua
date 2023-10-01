return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["sl"] = { query = "@assignment.lhs", desc = "Assignment left side" },
          ["sr"] = { query = "@assignment.rhs", desc = "Assignment right side" },
          ["au"] = { query = "@attribute.outer", desc = "Attribute outer" },
          ["iu"] = { query = "@attribute.inner", desc = "Attribute inner" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  },
}
