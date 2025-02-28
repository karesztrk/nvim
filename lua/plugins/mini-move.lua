return {
  "echasnovski/mini.move",
  event = "VeryLazy",
  opts = {

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = "",
      righ = "",
      down = "J",
      up = "K",

      -- Move current line in Normal mode
      line_left = "",
      line_right = "",
      line_down = "J",
      line_up = "K",
    },

    -- Options which control moving behavior
    options = {
      -- Automatically reindent selection during linewise vertical move
      reindent_linewise = false,
    },
  },
}
