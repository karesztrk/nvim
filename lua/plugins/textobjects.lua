return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["sl"] = { query = "@assignment.lhs", desc = "Assignment left side" },
          ["sr"] = { query = "@assignment.rhs", desc = "Assignment right side" },
          ["au"] = { query = "@attribute.outer", desc = "Attribute outer" },
          ["iu"] = { query = "@attribute.inner", desc = "Attribute inner" },
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
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
