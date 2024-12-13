return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    textobjects = {
      lsp_interop = {
        enable = true,
        border = "none",
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>tf"] = "@function.outer",
          ["<leader>tF"] = "@class.outer",
          ["<leader>ta"] = "@class.outer",
          ["<leader>tu"] = "@class.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next = {
          ["óa"] = "@parameter.outer",
          ["óf"] = "@function.outer",
          ["óu"] = "@attribute.outer",
        },
        goto_previous = {
          ["éa"] = "@parameter.outer",
          ["éf"] = "@function.outer",
          ["éu"] = "@attribute.outer",
        },
      },
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["sl"] = { query = "@assignment.lhs", desc = "Assignment left side" },
          ["sr"] = { query = "@assignment.rhs", desc = "Assignment right side" },
          ["aj"] = { query = "@assignment.outer", desc = "Assignment outer" },
          ["ij"] = { query = "@assignment.inner", desc = "Assignment inner" },
          ["aw"] = { query = "@attribute.outer", desc = "Attribute outer" },
          ["iw"] = { query = "@attribute.inner", desc = "Attribute inner" },
          ["ah"] = { query = "@conditional.outer", desc = "Conditional outer" },
          ["ih"] = { query = "@conditional.inner", desc = "Conditional inner" },
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
