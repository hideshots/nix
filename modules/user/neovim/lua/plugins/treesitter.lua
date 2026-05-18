return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "neovim-treesitter/treesitter-parser-registry" },
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers = {
      "c",
      "cpp",
      "cmake",
      "lua",
      "bash",
      "json",
      "yaml",
      "markdown",
      "markdown_inline",
    }

    local treesitter = require("nvim-treesitter")
    treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    local missing = vim.tbl_filter(function(parser)
      return #vim.api.nvim_get_runtime_file("parser/" .. parser .. ".so", false) == 0
    end, parsers)
    if #missing > 0 and vim.fn.executable("tree-sitter") == 1 then
      vim.schedule(function()
        treesitter.install(missing)
      end)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
      pattern = parsers,
      callback = function()
        if pcall(vim.treesitter.start) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end
}
