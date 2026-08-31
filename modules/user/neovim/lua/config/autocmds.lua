-- Autocmds
-- (Yank highlight removed in favor of undo-glow.nvim)

-- Jump to last cursor position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Jump to last cursor position when opening a file",
  callback = function(args)
    local ft = vim.bo[args.buf].filetype or ""
    if ft:match("commit") or ft:match("rebase") then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
