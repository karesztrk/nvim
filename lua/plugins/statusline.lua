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

local progress_state = {}

--- Start the spinner timer (only when there's active progress)

vim.api.nvim_create_autocmd('LspProgress', {
    callback = function(args)
        local client_id = args.data.client_id
        local params    = args.data.params
        local token     = params.token
        local value     = params.value
        local key       = tostring(client_id) .. ":" .. tostring(token)

        if value.kind == "begin" then
            progress_state[key] = {
                title      = value.title or "LSP",
                message    = value.message or "",
                percentage = value.percentage,
            }
        elseif value.kind == "report" then
            local task = progress_state[key]
            if task then
                task.message    = value.message or task.message
                task.percentage = value.percentage or task.percentage
            end
        elseif value.kind == "end" then
            progress_state[key] = nil
        end

        vim.cmd("redrawstatus")
    end,
})

-- Statusline function
local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

function _G.lsp_progress()
    if vim.tbl_isempty(progress_state) then return "" end
    return spinner_frames[math.floor(vim.uv.now() / 100) % #spinner_frames + 1]
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
        "%{v:lua.lsp_progress()} ",
        "%y ",
        "%{v:lua.statusline_active_lsp()} ",
        "%#StatusLineNormal#",
        vim.g.have_nerd_font and " " or " ", -- Right pill
        "%P ",
    })
}
