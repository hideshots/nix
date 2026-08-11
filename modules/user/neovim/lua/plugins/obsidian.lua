return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = {
    "ObsidianBacklinks",
    "ObsidianFollowLink",
    "ObsidianNew",
    "ObsidianNewFromTemplate",
    "ObsidianPasteImg",
    "ObsidianQuickSwitch",
    "ObsidianSearch",
    "ObsidianTemplate",
    "ObsidianToday",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  config = function(_, opts)
    local vault = "/mnt/hdd/Notes/Personal"

    local function set_vault_conceallevel(bufnr)
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name == vault or vim.startswith(name, vault .. "/") then
        vim.wo.conceallevel = 2
      end
    end

    set_vault_conceallevel(0)
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.md",
      callback = function(args)
        set_vault_conceallevel(args.buf)
      end,
    })

    if vim.fn.isdirectory(vault .. "/templates") == 0 then
      opts.templates = { folder = nil }
    end

    require("obsidian").setup(opts)
  end,
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/mnt/hdd/Notes/Personal",
      },
    },
    new_notes_location = "current_dir",
    note_id_func = function(title)
      if title then
        return title:gsub("[^%w%s%-]", ""):gsub("%s+", "-"):lower()
      end
      return tostring(os.time())
    end,
    templates = {
      folder = "templates",
    },
    attachments = {
      img_folder = "attachments",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    picker = {
      name = "telescope.nvim",
    },
  },
  keys = {
    { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Obsidian backlinks" },
    { "<leader>of", "<cmd>ObsidianFollowLink<CR>", desc = "Obsidian follow link" },
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "Obsidian new note" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian quick switch" },
    { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Obsidian search" },
    { "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "Obsidian today" },
    { "<leader>oT", "<cmd>ObsidianTemplate<CR>", desc = "Obsidian template" },
  },
}
