-- Thanks TJ - https://github.com/tjdevries/advent-of-nvim/blob/master/nvim/plugin/floaterminal.lua
-- Thanks radleylewis - https://github.com/radleylewis/nvim-lite/blob/master/init.lua

local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- Open a new floating terminal
local toggle_floating_terminal = function(opts)
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      local cmd = opts.fargs[1];
      if cmd then 
        vim.cmd.terminal(cmd)
      else 
        vim.cmd.terminal()
      end

      vim.cmd("startinsert")

      -- Set transparency for the floating window
      vim.api.nvim_win_set_option(state.floating.win, 'winblend', 0)

      -- Set transparent background for the window
      vim.api.nvim_win_set_option(state.floating.win, 'winhighlight',
        'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

      -- Define highlight groups for transparency
      vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Function to explicitly close the terminal
local function close_floating_terminal()
  if vim.api.nvim_win_is_valid(state.floating.win) then
    vim.api.nvim_win_close(state.floating.win, false)
  end
end

vim.api.nvim_create_user_command("FloatingTerminal", toggle_floating_terminal, { desc = "Open a floating terminal", nargs = '?' })
vim.api.nvim_create_user_command("CloseFloatingTerminal", close_floating_terminal, { desc = "Close a floating terminal", })
