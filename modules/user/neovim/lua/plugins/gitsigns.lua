return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "]c",
      function()
        require("gitsigns").nav_hunk("next")
      end,
      desc = "Next hunk",
    },
    {
      "[c",
      function()
        require("gitsigns").nav_hunk("prev")
      end,
      desc = "Previous hunk",
    },
    {
      "<leader>hs",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "Stage hunk",
    },
    {
      "<leader>hr",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "Reset hunk",
    },
    {
      "<leader>hp",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Preview hunk",
    },
    {
      "<leader>hb",
      function()
        require("gitsigns").blame_line({ full = true })
      end,
      desc = "Blame line",
    },
    {
      "<leader>tb",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      desc = "Toggle line blame",
    },
  },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    current_line_blame = false,
    preview_config = {
      border = "none",
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local opts = { buffer = bufnr, silent = true }

      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, vim.tbl_extend("force", opts, { desc = "Next hunk" }))
      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, vim.tbl_extend("force", opts, { desc = "Previous hunk" }))
      vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
      vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
      vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
      vim.keymap.set("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, vim.tbl_extend("force", opts, { desc = "Blame line" }))
      vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, vim.tbl_extend("force", opts, { desc = "Toggle line blame" }))
      vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, vim.tbl_extend("force", opts, { desc = "Inner hunk" }))
    end,
  },
}
