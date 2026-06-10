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
