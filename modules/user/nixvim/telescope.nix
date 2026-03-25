{ lib, ... }:

let
  mkRaw = lib.nixvim.mkRaw;
in
{
  keymaps = [
    {
      mode = "n";
      key = "<leader>jk";
      action = mkRaw ''
        function()
          require("telescope.builtin").find_files({
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          })
        end
      '';
      options.desc = "Find Files";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options.desc = "Find Files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
      options.desc = "Live Grep";
    }
    {
      mode = "n";
      key = "<leader>fd";
      action = "<cmd>Telescope diagnostics<CR>";
      options.desc = "Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>ds";
      action = "<cmd>Telescope lsp_document_symbols<CR>";
      options.desc = "Document Symbols";
    }
    {
      mode = "n";
      key = "<leader>ws";
      action = "<cmd>Telescope lsp_workspace_symbols<CR>";
      options.desc = "Workspace Symbols";
    }
    {
      mode = "n";
      key = "<leader>fv";
      action = "<cmd>Telescope help_tags<CR>";
      options.desc = "Help Tags";
    }
  ];

  plugins.telescope = {
    enable = true;
    enabledExtensions = [ "fzf" "ui-select" "zoxide" ];
    settings = {
      defaults = {
        border = {
          prompt = [ 1 1 1 1 ];
          results = [ 1 1 1 1 ];
          preview = [ 1 1 1 1 ];
        };
        borderchars = {
          prompt = [ " " " " "─" "│" "│" " " "─" "└" ];
          results = [ "─" " " " " "│" "┌" "─" " " "│" ];
          preview = [ "─" "│" "─" "│" "┬" "┐" "┘" "┴" ];
        };
      };

      extensions = {
        fzf = {
          fuzzy = true;
          override_generic_sorter = true;
          override_file_sorter = true;
          case_mode = "smart_case";
        };

        "ui-select" = mkRaw "require('telescope.themes').get_dropdown({})";
      };

      pickers = {
        colorscheme.enable_preview = true;
        find_files = {
          hidden = true;
          find_command = [
            "rg"
            "--files"
            "--glob"
            "!{.git/*,.next/*,.svelte-kit/*,target/*,node_modules/*}"
            "--path-separator"
            "/"
          ];
        };
      };
    };
  };
}
