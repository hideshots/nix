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

    local lsp_group = vim.api.nvim_create_augroup("user-lsp-keymaps", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_group,
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = event.buf,
            silent = true,
            desc = desc,
          })
        end

        local map_if = function(method, mode, lhs, rhs, desc)
          if client and client:supports_method(method) then
            map(mode, lhs, rhs, desc)
          end
        end

        map_if("textDocument/definition", "n", "gd", vim.lsp.buf.definition, "Go to definition")
        map_if("textDocument/declaration", "n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map_if("textDocument/references", "n", "gr", vim.lsp.buf.references, "List references")
        map_if("textDocument/implementation", "n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map_if("textDocument/typeDefinition", "n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
        map_if("textDocument/hover", "n", "K", vim.lsp.buf.hover, "Hover documentation")
        map_if("textDocument/rename", "n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map_if("textDocument/codeAction", { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map_if("textDocument/formatting", "n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, "Format buffer")

        map("n", "<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")

        if client and client:supports_method("textDocument/inlayHint") then
          map("n", "<leader>lh", function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
              { bufnr = event.buf }
            )
          end, "Toggle inlay hints")
        end
      end,
    })

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
