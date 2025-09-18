return {
  "nvim-mini/mini.files",
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowUpdate",
      callback = function(args)
        -- Show line numbers
        vim.wo[args.data.win_id].number = true
        vim.wo[args.data.win_id].relativenumber = true
      end,
    })
  end,
  opts = {
    mappings = {
      go_in = "<CR>", -- Map both Enter and L to enter directories or open files
      go_in_plus = "L",
      go_out = "-",
      go_out_plus = "H",
    },
  },
}
