return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({
          async = false,
          lsp_format = "fallback",
        })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local filetype = vim.bo[bufnr].filetype
      local disable = {
        markdown = true,
        text = true,
      }

      if disable[filetype] then
        return nil
      end

      return {
        lsp_format = "fallback",
        timeout_ms = 1000,
      }
    end,
    formatters_by_ft = {
      bash = { "shfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      lua = { "stylua" },
      nix = { "nixfmt" },
      rust = { "rustfmt" },
      json = { "jq" },
      yaml = { "yamlfmt", "prettier" },
      toml = { "taplo" },
      markdown = { "prettier" },
    },
  },
}
