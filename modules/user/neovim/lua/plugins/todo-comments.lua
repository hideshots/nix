return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    signs = true,
    keywords = {
      FIX = {
        icon = "!",
        color = "error",
      },
      TODO = {
        icon = "T",
        color = "info",
      },
      HACK = {
        icon = "H",
        color = "warning",
      },
      WARN = {
        icon = "W",
        color = "warning",
      },
      PERF = {
        icon = "P",
        color = "hint",
      },
      NOTE = {
        icon = "N",
        color = "hint",
      },
      TEST = {
        icon = "?",
        color = "hint",
      },
    },
    highlight = {
      before = "",
      keyword = "wide",
      after = "fg",
    },
    merge_keywords = true,
  },
}
