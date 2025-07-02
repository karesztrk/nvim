-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir

local palette = {
  grey_100 = "#0C001F",
  grey_90 = "#180D2A",
  grey_80 = "231934",
  grey_60 = "#322941",
  grey_40 = "#4E465B",
  grey_20 = "#E7E4E7",
  grey_10 = "#ECE9EC",
  grey_5 = "#F8F7F8",

  red_darker = "#BD0000",
  red_dark = "#E62424",
  red_light = "#FF7878",
  red_lighter = "#FFB8B8",

  orange_darker = "#D16100",
  orange_dark = "#F27C18",
  orange_light = "#FFB271",
  orange_lighter = "#FFDDC0",

  yellow_darker = "#D0BF00",
  yellow_dark = "#EEDA00",
  yellow_light = "#FFF373",
  yellow_lighter = "#FFF9BB",

  lime_darker = "#669900",
  lime_dark = "#7EBD00",
  lime_light = "#CBF37C",
  lime_lighter = "#E8FFBA",

  green_darker = "#009E35",
  green_dark = "#06B741",
  green_light = "#67E591",
  green_lighter = "#AEECC3",

  teal_darker = "#00837F",
  teal_dark = "#0CABA6",
  teal_light = "#52E7E1",
  teal_lighter = "#C4FFFD",

  blue_darker = "#005C8A",
  blue_dark = "#0081C2",
  blue_light = "#6BB5FF",
  blue_lighter = "#C3E7F9",

  purple_darker = "#280E54",
  purple_dark = "#4B1E97",
  purple_light = "#AD7DFF",
  purple_lighter = "#D5BDFF",

  pink_darker = "#B6034B",
  pink_dark = "#E62472",
  pink_light = "#FF82B4",
  pink_lighter = "#FFCFE3",
}

local function get_mode_color()
  -- auto change color according to neovims mode
  local mode_color = {
    n = palette.blue_dark,
    i = palette.pink_light,
    v = palette.purple_light,
    [""] = palette.purple_light,
    V = palette.purple_light,
    c = palette.red_light,
    no = palette.red_light,
    s = palette.orange_light,
    S = palette.orange_light,
    [""] = palette.orange_light,
    ic = palette.yellow_light,
    R = palette.lime_light,
    Rv = palette.lime_light,
    cv = palette.red_light,
    ce = palette.red_light,
    r = palette.teal_light,
    rm = palette.teal_light,
    ["r?"] = palette.teal_light,
    ["!"] = palette.green_light,
    t = palette.orange_light,
  }
  return { fg = mode_color[vim.fn.mode()] }
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = palette.grey_5, bg = "NONE" } },
      inactive = { c = { fg = palette.grey_5, bg = "NONE" } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end
ins_left({
  function()
    return "▌"
  end,
  color = get_mode_color,
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
  -- mode component
  function()
    return "󰯉"
  end,
  color = get_mode_color,
  padding = { right = 1 },
})

ins_left({
  "filename",
  cond = conditions.buffer_not_empty,
  color = { fg = palette.pink_light, gui = "bold" },
})

ins_left({
  -- filesize component
  "filesize",
  cond = conditions.buffer_not_empty,
})

ins_right({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = palette.red_light },
    color_warn = { fg = palette.orange_light },
    color_info = { fg = palette.blue_light },
  },
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
  function()
    return "%="
  end,
})

ins_left({
  -- Lsp server name .
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = "󰘦 LSP:",
  color = { fg = "#ffffff", gui = "bold" },
})

ins_right({
  "o:encoding", -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = palette.teal_light, gui = "bold" },
})

ins_right({
  "fileformat",
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = palette.teal_light, gui = "bold" },
})

return {
  "nvim-lualine/lualine.nvim",
  opts = config,
}
