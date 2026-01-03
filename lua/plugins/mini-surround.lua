vim.pack.add({
  "https://github.com/nvim-mini/mini.surround.git",
})

-- mini.surround configuration
require("mini.surround").setup({
  mappings = {
    -- Using <leader> is easier
    add = "<leader>sa",       -- Add surrounding in Normal and Visual modes
    delete = "<leader>sd",    -- Delete surrounding
    find = "gsf",             -- Find surrounding (to the right)
    find_left = "gsF",        -- Find surrounding (to the left)
    highlight = "gsh",        -- Highlight surrounding
    replace = "<leader>sc",   -- Change surrounding
    update_n_lines = "gsn",   -- Update `n_lines`
  },
})
