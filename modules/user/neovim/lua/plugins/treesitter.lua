return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ignore_install = {},
      ensure_installed = {
        "c",
        "cpp",
        "cmake",
        "lua",
        "bash",
        "json",
        "yaml",
        "markdown",
      },
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      modules = {},
      sync_install = true,
      auto_install = true,
    })
  end
}
