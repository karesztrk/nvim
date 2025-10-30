return {
  "saghen/blink.cmp",
  version = not vim.g.lazyvim_blink_main and "*",
  build = vim.g.lazyvim_blink_main and "cargo build --release",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- "fang2hou/blink-copilot",
    -- add blink.compat to dependencies
    {
      "saghen/blink.compat",
      optional = true, -- make optional so it's only enabled if any extras need it
      opts = {},
      version = not vim.g.lazyvim_blink_main and "*",
    },
  },
  event = { "InsertEnter", "CmdlineEnter" },
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
    opts.appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = false,
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    }

    opts.completion = {
      accept = {
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
          treesitter = { "lsp" },
          align_to = "cursor",
          columns = {
            { "kind_icon" },
            { "label", gap = 1 },
          },
        },
      },
      documentation = {
        window = {
          border = "rounded",
          winblend = 0,
        },
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

    -- experimental signature help support
    opts.signature = { enabled = true }

    opts.sources = {
      default = {
        -- "copilot",
        "lsp",
        "path",
        "snippets",
        "buffer",
      },
      -- providers = {
      --   copilot = {
      --     name = "copilot",
      --     module = "blink-copilot",
      --     async = true,
      --   },
      -- },
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
