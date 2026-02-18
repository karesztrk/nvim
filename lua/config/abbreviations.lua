local abbreviations = {
  btw = "by the way",
  imo = "in my opinion",
  nvim = "neovim"
}

for typo, correct in pairs(abbreviations) do
  vim.cmd("abbr " .. typo .. " " .. correct)
end
