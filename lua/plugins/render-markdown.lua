return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    heading = {
      sign = false,
      position = "inline",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    html = {
      comment = {
        conceal = true,
        text = "~",
      },
    },
    checkbox = {
      enabled = true,
      render_modes = false,
      bullet = false,
      unchecked = {
        icon = "󰄱 ",
        scope_highlight = nil,
      },
      checked = {
        icon = "󰱒 ",
        scope_highlight = "@markup.strikethrough",
      },
    },
  },
}
