return {
  "xiyaowong/telescope-emoji.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<leader>se",
      "<cmd>Telescope emoji<cr>",
      desc = "emoji search",
    },
  },
  opts = {
    extensions = {
      emoji = {
        action = function(emoji)
          -- insert emoji when picked
          vim.api.nvim_put({ emoji.value }, "c", false, true)
        end,
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("emoji")
  end,
}
