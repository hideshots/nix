return {
  "romgrk/barbar.nvim",
  cond = not vim.g.started_by_firenvim,
  lazy = false,
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    animation = true,
    insert_at_start = false,
    auto_hide = 1,
    minimum_padding = 1,
    maximum_padding = 1,
    icons = {
      button = false,
      filetype = { custom_colors = false },
      separator = { left = '', right = '' },
      inactive = { separator = { left = '', right = '' } },
    },
  },
  config = function(_, opts)
    require("barbar").setup(opts)

    local function set_custom_highlights()
      local active_fg = "#888888"
      local inactive_fg = "#444444"
      local visible_fg = "#666666"

      local current = { "BufferCurrent", "BufferCurrentIndex", "BufferCurrentMod", "BufferCurrentSign", "BufferCurrentTarget" }
      for _, group in ipairs(current) do
        vim.api.nvim_set_hl(0, group, { fg = active_fg, bg = "NONE", bold = false })
      end

      local inactive = { "BufferInactive", "BufferInactiveIndex", "BufferInactiveMod", "BufferInactiveSign", "BufferInactiveTarget", "BufferAlternate", "BufferAlternateIndex", "BufferAlternateMod", "BufferAlternateSign", "BufferAlternateTarget" }
      for _, group in ipairs(inactive) do
        vim.api.nvim_set_hl(0, group, { fg = inactive_fg, bg = "NONE", bold = false })
      end

      local visible = { "BufferVisible", "BufferVisibleIndex", "BufferVisibleMod", "BufferVisibleSign", "BufferVisibleTarget" }
      for _, group in ipairs(visible) do
        vim.api.nvim_set_hl(0, group, { fg = visible_fg, bg = "NONE", bold = false })
      end

      vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "NONE", fg = "NONE" })
    end

    set_custom_highlights()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.schedule(set_custom_highlights)
      end,
    })
  end,
  keys = {
    { "<S-h>", "<Cmd>BufferPrevious<CR>", desc = "Previous buffer" },
    { "<S-l>", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
    { "<A-<>", "<Cmd>BufferMovePrevious<CR>", desc = "Move buffer left" },
    { "<A->>", "<Cmd>BufferMoveNext<CR>", desc = "Move buffer right" },
    { "<leader>bc", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
    { "<leader>bp", "<Cmd>BufferPin<CR>", desc = "Pin buffer" },
    { "<leader>bP", "<Cmd>BufferPick<CR>", desc = "Pick buffer" },
  },
}