return {
  "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
  -- Activate when a file is created/opened
  event = { "BufReadPre", "BufNewFile" },
  -- Activate when a supported filetype is open
  ft = { "go", "javascript", "python", "ruby" },
  cond = function()
    -- Only activate if token is present in environment variable.
    -- Remove this line to use the interactive workflow.
    return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ""
  end,
  opts = {
    statusline = {
      -- Hook into the built-in statusline to indicate the status
      -- of the GitLab Duo Code Suggestions integration
      enabled = true,
    },
  },
  code_suggestions = {
    -- For the full list of default languages, see the 'auto_filetypes' array in
    -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
    auto_filetypes = {
      "c", -- C
      "cpp", -- C++
      "csharp", -- C#
      "go", -- Golang
      "java", -- Java
      "javascript", -- JavaScript
      "javascriptreact", -- JavaScript React
      "kotlin", -- Kotlin
      "markdown", -- Markdown
      "objective-c", -- Objective-C
      "objective-cpp", -- Objective-C++
      "php", -- PHP
      "python", -- Python
      "ruby", -- Ruby
      "rust", -- Rust
      "scala", -- Scala
      "sql", -- SQL
      "swift", -- Swift
      "terraform", -- Terraform
      "typescript", -- TypeScript
      "typescriptreact", -- TypeScript React
      "sh", -- Shell scripts
      "html", -- HTML
      "css", -- CSS
    }, -- Default is { 'ruby' }
    ghost_text = {
      enabled = false, -- ghost text is an experimental feature
      toggle_enabled = "<C-h>",
      accept_suggestion = "<C-l>",
      clear_suggestions = "<C-k>",
      stream = true,
    },
  },
}
