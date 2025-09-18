return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      local paths = {
        "~/.config/nvim/snippets/",
      }
      -- paths[#paths + 1] = Util.get_root() .. "nvim" .. "lazy" .. "friendly-snippets"
      require("luasnip.loaders.from_vscode").lazy_load({ paths = paths })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
