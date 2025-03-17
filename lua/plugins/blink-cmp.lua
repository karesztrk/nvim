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
    opts.fuzzy = {
      sorts = { "score", "sort_text" },
    }
    opts.completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        direction_priority = { "n", "s" },
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                if ctx.kind == "Codeium" then
                  -- AI code items are grayed out
                  return "Comment"
                end

                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
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
    }
    -- My preferred way of selection
    opts.keymap = {
      preset = "enter",
      ["<A-Enter>"] = {
        LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
        "fallback",
      },
    }
  end,
}
