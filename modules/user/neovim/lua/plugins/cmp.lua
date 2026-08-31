return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "milanglacier/minuet-ai.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      local minuet_virtualtext = require("minuet.virtualtext").action

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if minuet_virtualtext.is_visible() then
              minuet_virtualtext.accept()
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        performance = {
          fetching_timeout = 2000,
        },
      })
    end,
    keys = {
      {
        "<leader>cp",
        function()
          local output = vim.fn.system({ "curl", "-fsS", "http://127.0.0.1:1234/api/v1/models" })
          local loaded = false

          if vim.v.shell_error == 0 and output ~= "" then
            local ok, decoded = pcall(vim.json.decode, output)
            if ok and decoded then
              for _, item in ipairs(decoded.models or {}) do
                if item.key == "qwen2.5-coder-3b-instruct" then
                  loaded = #(item.loaded_instances or {}) > 0
                  break
                end
              end
            end
          end

          if not loaded then
            vim.notify("Minuet skipped: qwen2.5-coder-3b-instruct is not loaded", vim.log.levels.WARN,
              { title = "Minuet" })
            return
          end

          vim.cmd("Minuet virtualtext toggle")
          vim.notify("Minuet virtualtext toggled", vim.log.levels.INFO, { title = "Minuet" })
        end,
        desc = "Toggle AI inline completion",
      },
    },
  },
}
