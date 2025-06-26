return {
  "saghen/blink.cmp",
  dependencies = {
    "saghen/blink.compat",
  },
  opts = function(_, opts)
    opts.enabled = function()
      -- Get the current buffer's filetype
      local filetype = vim.bo[0].filetype
      -- Disable for pickers
      if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
        return false
      end
      return true
    end
    opts.fuzzy = {
      sorts = { "score", "sort_text" },
      use_frecency = false,
    }
    opts.completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        auto_show = false, -- only show menu on manual <C-space>
        direction_priority = { "n", "s" },
        border = {
          { "󱐋", "BlinkCmpMenuIcon" },
          "─",
          "╮",
          "│",
          "╯",
          "─",
          "╰",
          "│",
        },
        draw = {
          align_to = "cursor",
          columns = {
            { "kind_icon" },
            { "label", gap = 1 },
          },
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
        show_with_menu = false, -- only show when menu is closed
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
      preset = "default",
      ["<Right>"] = { "select_and_accept" },
    }
    opts.cmdline = {
      enabled = false,
    }
  end,
}
