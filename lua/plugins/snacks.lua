local pick = nil

pick = function()
  if LazyVim.pick.picker.name == "telescope" then
    return vim.cmd("Telescope projects")
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local project = require("project_nvim.project")
    local history = require("project_nvim.utils.history")
    local results = history.get_recent_projects()
    local utils = require("fzf-lua.utils")

    local function hl_validate(hl)
      return not utils.is_hl_cleared(hl) and hl or nil
    end

    local function ansi_from_hl(hl, s)
      return utils.ansi_from_hl(hl_validate(hl), s)
    end

    local opts = {
      fzf_opts = {
        ["--header"] = string.format(
          ":: <%s> to %s | <%s> to %s | <%s> to %s | <%s> to %s | <%s> to %s",
          ansi_from_hl("FzfLuaHeaderBind", "ctrl-t"),
          ansi_from_hl("FzfLuaHeaderText", "tabedit"),
          ansi_from_hl("FzfLuaHeaderBind", "ctrl-s"),
          ansi_from_hl("FzfLuaHeaderText", "live_grep"),
          ansi_from_hl("FzfLuaHeaderBind", "ctrl-r"),
          ansi_from_hl("FzfLuaHeaderText", "oldfiles"),
          ansi_from_hl("FzfLuaHeaderBind", "ctrl-w"),
          ansi_from_hl("FzfLuaHeaderText", "change_dir"),
          ansi_from_hl("FzfLuaHeaderBind", "ctrl-d"),
          ansi_from_hl("FzfLuaHeaderText", "delete")
        ),
      },
      fzf_colors = true,
      actions = {
        ["default"] = {
          function(selected)
            fzf_lua.files({ cwd = selected[1] })
          end,
        },
        ["ctrl-t"] = {
          function(selected)
            vim.cmd("tabedit")
            fzf_lua.files({ cwd = selected[1] })
          end,
        },
        ["ctrl-s"] = {
          function(selected)
            fzf_lua.live_grep({ cwd = selected[1] })
          end,
        },
        ["ctrl-r"] = {
          function(selected)
            fzf_lua.oldfiles({ cwd = selected[1] })
          end,
        },
        ["ctrl-w"] = {
          function(selected)
            local path = selected[1]
            local ok = project.set_pwd(path)
            if ok then
              vim.api.nvim_win_close(0, false)
              LazyVim.info("Change project dir to " .. path)
            end
          end,
        },
        ["ctrl-d"] = function(selected)
          local path = selected[1]
          local choice = vim.fn.confirm("Delete '" .. path .. "' project? ", "&Yes\n&No")
          if choice == 1 then
            history.delete_project({ value = path })
          end
          pick()
        end,
      },
    }

    fzf_lua.fzf_exec(results, opts)
  end
end

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>,",
      function()
        Snacks.picker.buffers({
          finder = "buffers",
          format = "buffer",
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["dd"] = "bufdelete",
              },
            },
            list = { keys = { ["dd"] = "bufdelete" } },
          },
        })
      end,
      desc = "Snacks picker buffers",
    },
    {
      "<leader>se",
      function()
        Snacks.picker.icons()
      end,
      desc = "Snacks picker icons",
    },
    {
      "<leader><space>",
      LazyVim.pick("files", { focus = "input" }),
      desc = "Find Files (Root Dir)",
    },
    {
      "<leader>sg",
      LazyVim.pick("live_grep", { focus = "input", hidden = true }),
      desc = "Grep (Root Dir)",
    },
  },
  opts = {
    statuscolumn = {
      -- I prefer the default status column look'n'feel
      enabled = false,
    },
    image = {
      enabled = true,
      doc = {
        inline = false,
        float = true,
        max_width = 80,
        max_height = 40,
      },
    },
    picker = {
      -- I always want my buffers picker to start in normal mode
      focus = "list",
      layout = {
        preset = "vertical", -- default layout
        cycle = false, -- cycle through pickers
      },
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            ["<Tab>"] = { "focus_preview", mode = { "i", "n" } },
            ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
            ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
          },
        },
      },
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 40,
          filename_only = false,
          icon_width = 2,
          git_status_hl = true,
        },
      },
    },

    lazygit = {
      theme = {
        [241] = { fg = "Special" },
        activeBorderColor = { fg = "Cursor", bold = true },
        cherryPickedCommitBgColor = { fg = "Identifier" },
        cherryPickedCommitFgColor = { fg = "Function" },
        defaultFgColor = { fg = "Normal" },
        inactiveBorderColor = { fg = "FloatBorder" },
        optionsTextColor = { fg = "Function" },
        searchingActiveBorderColor = { fg = "MatchParen", bold = true },
        selectedLineBgColor = { bg = "CursorLine" },
        unstagedChangesColor = { fg = "DiagnosticError" },
      },
    },
    dashboard = {
      enabled = false,
    },
  },
}
