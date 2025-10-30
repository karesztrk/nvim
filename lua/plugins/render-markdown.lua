return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    link = {
      -- Turn on / off inline link icon rendering.
      enabled = true,
      -- Additional modes to render links.
      render_modes = false,
      -- How to handle footnote links, start with a '^'.
      footnote = {
        -- Turn on / off footnote rendering.
        enabled = true,
        -- Inlined with content.
        icon = "󰯔 ",
        -- Replace value with superscript equivalent.
        superscript = true,
        -- Added before link content.
        prefix = "",
        -- Added after link content.
        suffix = "",
      },
      custom = {
        web = { pattern = "^http", icon = "󰖟 " },
        jira = { pattern = "atlassian.net", icon = " " },
        github = { pattern = "github%.com", icon = "󰊤 " },
        gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
        stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
        slack = { pattern = "slack.com", icon = " " },
      },
    },
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
