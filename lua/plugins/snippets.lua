local js_base = {
  clg = "console.log($1)",
  fn = "function $1($2) {\n\t$0\n}",
  arr = "const $1 = ($2) => {\n\t$0\n}",
  req = "const $1 = require('$2')",
  imp = "import $1 from '$2'",
}

local react_extra = {
  uses = "const [$1, set${1/(.*)/${1:/capitalize}/}] = useState($2)",
  usef = "useEffect(() => {\n\t$0\n}, [$1])",
}

local snippets = {
  lua = {
    req = "local $1 = require('$1')",
    func = "local function $1($2)\n\t$0\nend",
  },
  javascript = js_base,
  typescript = js_base,
  javascriptreact = vim.tbl_extend("force", js_base, react_extra),
  typescriptreact = vim.tbl_extend("force", js_base, react_extra),
}

-- Function to expand a snippet based on the word under the cursor
_G.expand_snippet = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]
  local line = vim.api.nvim_get_current_line()

  -- Find the word behind the cursor
  local before_cursor = line:sub(1, col)
  local word = before_cursor:match("(%w+)$")
  local ft = vim.bo.filetype

  if word and snippets[ft] and snippets[ft][word] then
    local snip = snippets[ft][word]
    -- INSTANTLY delete the trigger word from the buffer
    local start_col = col - #word
    vim.api.nvim_buf_set_text(0, row, start_col, row, col, {})

    -- Move cursor to where the word started, then expand
    vim.api.nvim_win_set_cursor(0, { row + 1, start_col })
    vim.snippet.expand(snip)
  else
    -- If no snippet found, just insert a newline or literal Ctrl-k
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-k>", true, false, true), "n", true)
  end
end
