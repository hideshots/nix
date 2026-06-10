return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  dependencies = { "neovim-treesitter/treesitter-parser-registry" },
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    local languages = {
      "bash",
      "c",
      "cpp",
      "qmljs",
      "lua",
      "nix",
      "rust",
      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "query",
    }

    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    pcall(ts.install, languages)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "bash",
        "c",
        "cpp",
        "qml",
        "lua",
        "nix",
        "rust",
        "json",
        "yaml",
        "toml",
        "markdown",
        "vim",
        "help",
        "query",
      },
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
