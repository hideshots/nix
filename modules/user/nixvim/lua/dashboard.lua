vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local header_color = "#4a4a4a"
local footer_color = "#262626"

vim.api.nvim_set_hl(0, "DashboardHeader", { fg = header_color, bg = "NONE" })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = footer_color, bg = "NONE" })

vim.api.nvim_create_autocmd("User", {
  pattern = "DashboardReady",
  callback = function()
    vim.cmd(string.format("highlight DashboardHeader guifg=%s guibg=NONE", header_color))
    vim.cmd(string.format("highlight DashboardFooter guifg=%s guibg=NONE", footer_color))
  end,
})
