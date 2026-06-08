return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      ignore = nil,
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })

    local api = require("Comment.api")

    vim.keymap.set("n", "<leader>/", api.toggle.linewise.current, {
      desc = "Toggle comment on current line",
      silent = true,
    })

    vim.keymap.set("x", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {
      desc = "Toggle comment on selection",
      silent = true,
    })
  end,
}
