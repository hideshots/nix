return {
  "oxy2dev/markview.nvim",
  version = "*",
  ft = { "markdown", "markdown_inline", "gitcommit" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local markview = require("markview")

    markview.setup({
      adaptive_options = true,
      markdown = {
        enable = true,

        headings = {
          enabled = true,
        },

        code_blocks = {
          enabled = true,
        },

        tables = {
          enabled = true,
        },

        list_items = {
          enabled = true,
        },

        block_quotes = {
          enabled = true,
        },

        horizontal_rules = {
          enabled = true,
        },
      },
    })
  end,
  keys = {
    { "<leader>sv", "<cmd>Markview splitToggle<cr>", desc = "Toggle splitview", ft = { "markdown", "markdown_inline", "gitcommit" } },
    { "<leader>sh", "<cmd>Markview hybridToggle<cr>", desc = "Toggle hybrid mode", ft = { "markdown", "markdown_inline", "gitcommit" } },
  },
}
