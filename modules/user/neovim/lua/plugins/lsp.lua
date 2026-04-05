return {
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "prepend",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        -- "cmake", -- disable for now on Arch + Python 3.14
        "bashls",
        "jsonls",
        "yamlls",
        "marksman",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_markers = {
          "compile_commands.json",
          "compile_flags.txt",
          "CMakeLists.txt",
          ".git",
        },
      })

      vim.lsp.config("jsonls", { capabilities = capabilities })
      vim.lsp.config("yamlls", { capabilities = capabilities })
      vim.lsp.config("marksman", { capabilities = capabilities })
      vim.lsp.config("bashls", { capabilities = capabilities })

      vim.lsp.enable({
        "clangd",
        "bashls",
        "jsonls",
        "yamlls",
        "marksman",
      })
    end,
  },
}
