return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    size = 15,
    open_mapping = [[<A-h>]],
    direction = "horizontal",
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    close_on_exit = true,
  },
  keys = {
    { "<A-h>", "<cmd>ToggleTerm direction=horizontal<cr>", mode = { "n", "i", "t" }, desc = "Toggle horizontal terminal" },
  },
}
