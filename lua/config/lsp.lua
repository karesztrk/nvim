-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in nvim-lspconfig/lsp/lua_ls.lua for lua_ls, for example.
vim.lsp.enable({
    "astro",  -- @astrojs/language-server
    "biome",  -- @biomejs/biome
    "cssls",  -- vscode-langservers-extracted
    "eslint", -- vscode-langservers-extracted
    "html",   -- vscode-langservers-extracted
    "lua_ls", -- lua-language-server
    "ts_ls"   -- typescript-language-server
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- Built-in completion
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.lsp.completion.enable(true, client.id, args.buf, {
                autotrigger = true,
                convert = function(item)
                    return { abbr = item.label:gsub("%b()", "") }
                end,
                cmp = function(a, b)
                    -- Prioritize items starting with underscore lower
                    local a_underscore = a.word:match('^_')
                    local b_underscore = b.word:match('^_')

                    if a_underscore ~= b_underscore then
                        return b_underscore
                    end

                    -- Fall back to default sort
                    local item_a = a.user_data.nvim.lsp.completion_item
                    local item_b = b.user_data.nvim.lsp.completion_item
                    return (item_a.sortText or item_a.label) < (item_b.sortText or item_b.label)
                end
            })
        end


        -- Inlay hints
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end

        -- Coloring
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentColor) then
            vim.lsp.document_color.enable(true, { bufnr = args.buf }, {
                style = "background", -- 'background', 'foreground', or 'virtual'
            })
        end
    end,
})

vim.lsp.config('ts_ls', {
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = 'literals',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = 'literals',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    },
})


-- Diagnostics
vim.diagnostic.config({
    -- keep underline & severity_sort on for quick scanning
    underline = true,
    severity_sort = true,
    update_in_insert = false, -- less flicker
    float = {
        border = "rounded",
        source = true,
    },
    virtual_text = false,
    virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
    },
    -- signs = vim.g.have_nerd_font and {
    --   text = {
    --     [vim.diagnostic.severity.ERROR] = '󰅚 ',
    --     [vim.diagnostic.severity.WARN] = '󰀪 ',
    --     [vim.diagnostic.severity.INFO] = '󰋽 ',
    --     [vim.diagnostic.severity.HINT] = '󰌶 ',
    --   },
    -- } or {},
})
