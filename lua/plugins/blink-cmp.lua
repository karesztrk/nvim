return {
  "saghen/blink.cmp",
  dependencies = { "codeium.nvim", "saghen/blink.compat" },
  opts = function(_, opts)
    opts.enabled = function()
      -- Get the current buffer's filetype
      return not vim.tbl_contains({ "minifiles", "snacks_picker_input" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end
    opts.completion = {
      list = {
        -- Do select the first, dont auto insert on selection
        selection = {
          preselect = true,
          auto_insert = false,
        },
        -- Menu cycle is turned off
        cycle = {
          from_bottom = false,
          from_top = false,
        },
      },

      -- Do show ghost text
      ghost_text = { enabled = true },
      -- Manually open the completion menu
      menu = {
        auto_show = false,
        direction_priority = { "n", "s" },
      },
    }
    -- My preferred way of selection
    opts.keymap = {
      preset = "default",
      ["<Right>"] = { "select_and_accept" },
    }
  end,
}
