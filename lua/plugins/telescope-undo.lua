return {
  "debugloop/telescope-undo.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  keys = {
    {
      "<leader>su",
      "<cmd>Telescope undo<cr>",
      desc = "undo history",
    },
  },
  opts = {
    extensions = {
      undo = {
        use_delta = true,
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("undo")
  end,
}
