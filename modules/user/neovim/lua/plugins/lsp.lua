return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    vim.diagnostic.config({
      virtual_text = false,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "none",
        source = "if_many",
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })

    local function has_bin(bin)
      return vim.fn.executable(bin) == 1
    end

    local function enable_if_installed(name, bin, config)
      if not has_bin(bin) then
        return
      end

      vim.lsp.config(name, vim.tbl_extend("force", {
        capabilities = capabilities,
      }, config or {}))
      vim.lsp.enable(name)
    end

    if has_bin("lua-language-server") then
      vim.lsp.config("lua_ls", {
        root_markers = {
          ".luarc.json",
          ".luarc.jsonc",
          ".luacheckrc",
          ".stylua.toml",
          ".git",
        },
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME .. "/lua",
              },
            },
            telemetry = {
              enable = false,
            },
          },
        },
        capabilities = capabilities,
      })
      vim.lsp.enable("lua_ls")
    end

    enable_if_installed("clangd", "clangd")

    if has_bin("rust-analyzer") then
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            check = {
              command = "clippy",
            },
          },
        },
        capabilities = capabilities,
      })
      vim.lsp.enable("rust_analyzer")
    end

    enable_if_installed("nixd", "nixd")

    enable_if_installed("bashls", "bash-language-server")
    enable_if_installed("jsonls", "vscode-json-language-server")
    enable_if_installed("yamlls", "yaml-language-server")
    enable_if_installed("marksman", "marksman")
    enable_if_installed("taplo", "taplo")
  end,
}
