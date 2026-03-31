vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        -- 'main' branch is instable and requires tree-sitter-cli v0.26.1+ (which is also instable)
        version = "main",
    },
})

require("nvim-treesitter").install {
    "astro",
    "bash",
    "fish",
    "comment",
    "css",
    "diff",
    "dockerfile",
    "fish",
    "gitcommit",
    "gitignore",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "query",
    "regex",
    "rust",
    "scss",
    "sql",
    "terraform",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
}

vim.api.nvim_create_autocmd('PackChanged', {
    desc = 'Handle nvim-treesitter updates',
    group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
    callback = function(event)
        if event.data.kind == 'update' and event.data.spec.name == 'nvim-treesitter' then
            vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
            ---@diagnostic disable-next-line: param-type-mismatch
            local ok = pcall(vim.cmd, 'TSUpdate')
            if ok then
                vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
            else
                vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
            end
        end
    end,
})
