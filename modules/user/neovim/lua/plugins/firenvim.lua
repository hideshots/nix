return {
  "glacambre/firenvim",
  lazy = not vim.g.started_by_firenvim,
  build = function()
    require("lazy").load({ plugins = { "firenvim" }, wait = true })
    vim.fn["firenvim#install"](0)
  end,
  init = function()
    vim.g.firenvim_config = {
      globalSettings = { alt = "all" },
      localSettings = {
        [".*"] = {
          cmdline = "neovim",
          content = "text",
          priority = 0,
          selector = 'textarea, div[role="textbox"], [contenteditable="true"], input:not([type="password"])',
          takeover = "never",
        },
      },
    }
  end,
  config = function()
    vim.api.nvim_create_autocmd({ "UIEnter" }, {
      callback = function(event)
        local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == "Firenvim" then
          vim.o.laststatus = 0
          vim.o.showtabline = 0
        end
      end,
    })
  end,
}
