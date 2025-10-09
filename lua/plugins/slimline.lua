local invader = "󰯉"
local ghost = "󰊠"
local pacman = "󰮯"
local mushroom = "󰟟"
local tank = "󰴺"

return {
  "sschleemilch/slimline.nvim",
  opts = {
    spaces = {
      components = "",
    },
    style = "fg",
    bold = false,
    hl = {
      base = "Cursor",
      primary = "Label",
      secondary = "DiagnosticUnnecessary",
    },
    configs = {
      mode = {
        style = "bg",
        verbose = false,
        sep = {
          left = "",
          right = "█◣",
        },
        hl = {
          normal = "Function",
          visual = "Define",
          insert = "Number",
          replace = "Number",
          command = "Question",
          other = "Normal",
        },
        format = {
          ["n"] = {
            -- verbose = "NORMAL"
            short = invader,
          },
          ["v"] = {
            -- verbose = "VISUAL",
            short = ghost,
          },
          ["V"] = {
            -- verbose = "V-LINE",
            short = ghost,
          },
          ["\22"] = {
            -- verbose = "V-BLOCK",
            short = ghost,
          },
          ["i"] = {
            -- verbose = "INSERT",
            short = pacman,
          },
          ["R"] = {
            -- verbose = "REPLACE",
            short = pacman,
          },
          ["c"] = {
            -- verbose = "COMMAND",
            short = tank,
          },
          ["t"] = {
            -- verbose = "TERMINAL",
            short = mushroom,
          },
        },
      },
      path = {
        directory = false,
        hl = {
          primary = "Label",
        },
        icons = {
          folder = " ",
          modified = "",
          read_only = "",
        },
      },
      filetype_lsp = {
        style = "bg",
        hl = {
          primary = "Function",
          secondary = "NotifyINFOTitle",
        },
        sep = {
          left = "",
          right = "",
        },
        lsp_sep = "+",
      },
    },
    components = {
      left = {
        "mode",
        "path",
      },
      center = {},
      right = {
        "diagnostics",
        "filetype_lsp",
        "recording",
      },
    },
  },
}
