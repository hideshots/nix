return {
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    local model_name = "qwen2.5-coder-3b-instruct"

    local function probe_model()
      local output = vim.fn.system({ "curl", "-fsS", "http://127.0.0.1:1234/api/v1/models" })

      if vim.v.shell_error == 0 and output ~= "" then
        local ok, decoded = pcall(vim.json.decode, output)
        if ok and decoded then
          for _, item in ipairs(decoded.models or {}) do
            if item.key == model_name then
              return #(item.loaded_instances or {}) > 0
            end
          end
        end
      end

      return false
    end

    local model_available = probe_model()

    require("minuet").setup({
      provider = "openai_compatible",
      virtualtext = {
        auto_trigger_ft = model_available and { "*" } or {},
        show_on_completion_menu = false,
        keymap = {
          prev = "<C-h>",
          next = "<C-l>",
          dismiss = "<C-e>",
        },
      },
      provider_options = {
        openai_compatible = {
          name = "LM Studio",
          model = "qwen2.5-coder-3b-instruct",
          end_point = "http://127.0.0.1:1234/v1/chat/completions",
          api_key = function()
            return "lm-studio"
          end,
          stream = true,
          optional = {
            max_tokens = 128,
          },
        },
      },
    })

    if model_available then
      vim.schedule(function()
        pcall(vim.cmd, "Minuet virtualtext enable")
      end)
    end
  end,
}
