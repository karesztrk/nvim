local invader = "󰯉"
local ghost = "󰊠"
local pacman = "󰮯"
local mushroom = "󰟟"
local tank = "󰴺"

local mode_map = {
  ['n']   = { name = 'NORMAL', hl = 'StatusLineNormal' },
  ['i']   = { name = 'INSERT', hl = 'StatusLineInsert' },
  ['v']   = { name = 'VISUAL', hl = 'StatusLineVisual' },
  ['V']   = { name = 'V-LINE', hl = 'StatusLineVisual' },
  ['\22'] = { name = 'V-BLOCK', hl = 'StatusLineVisual' }, -- Ctrl-V
  ['c']   = { name = 'COMMAND', hl = 'StatusLineCommand' },
  ['s']   = { name = 'SELECT', hl = 'StatusLineSelect' },
  ['S']   = { name = 'S-LINE', hl = 'StatusLineSelect' },
  ['\19'] = { name = 'S-BLOCK', hl = 'StatusLineSelect' }, -- Ctrl-S
  ['r']   = { name = 'REPLACE', hl = 'StatusLineReplace' },
  ['R']   = { name = 'REPLACE', hl = 'StatusLineReplace' },
  ['!']   = { name = 'SHELL', hl = 'StatusLineShell' },
  ['t']   = { name = 'TERMINAL', hl = 'StatusLineTerminal' },
}

-- Mode indicators with icons
function _G.statusline_mode_icon()
  local mode = vim.fn.mode()

  if vim.g.have_nerd_font then
    mode_map.n.name = invader;
    mode_map.i.name = pacman;
    mode_map.v.name = ghost;
    mode_map.V.name = ghost;
    mode_map["\22"].name = ghost;
    mode_map.c.name = tank;
    mode_map.R.name = pacman;
    mode_map.r.name = pacman;
    mode_map.t.name = mushroom;
  end
  return mode_map[mode].name or 'OTHER'
end

function _G.statusline_mode_color()
  local mode = vim.fn.mode()

  local mode_data = mode_map[mode].hl or 'StatusLine'
  return "%#" .. mode_data .. "#"
end

function _G.statusline_active_lsp()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ""
  end

  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return "[" .. table.concat(names, "+") .. "]"
end

return {
  statusline = table.concat({
    "%{%v:lua.statusline_mode_color()%} %{v:lua.statusline_mode_icon()} ",
    vim.g.have_nerd_font and "" or "", -- Left pill
    "%* ", -- Reset hl-group
    "%t ",
    "%h%m%r",
    "%=", -- Right-align everything after this
    "%S ",
    "%y ",
    "%{v:lua.statusline_active_lsp()} ",
    "%#StatusLineNormal#",
    vim.g.have_nerd_font and " " or " ", -- Right pill
    "%P ",
  })
}
