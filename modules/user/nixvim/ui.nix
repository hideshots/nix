{ lib, ... }:

let
  mkRaw = lib.nixvim.mkRaw;
in
{
  keymaps = [
    {
      mode = "n";
      key = "<leader>cp";
      action = "<cmd>CccPick<CR>";
      options.desc = "Color picker";
    }
    {
      mode = "n";
      key = "<leader>ch";
      action = "<cmd>CccHighlighterToggle<CR>";
      options.desc = "Hide Color picker";
    }

    {
      mode = [ "n" "x" "o" ];
      key = "zk";
      action = mkRaw "function() require('flash').jump() end";
      options.desc = "Flash";
    }
    {
      mode = [ "n" "x" "o" ];
      key = "Zk";
      action = mkRaw "function() require('flash').treesitter() end";
      options.desc = "Flash Treesitter";
    }
    {
      mode = "o";
      key = "r";
      action = mkRaw "function() require('flash').remote() end";
      options.desc = "Remote Flash";
    }
    {
      mode = [ "o" "x" ];
      key = "R";
      action = mkRaw "function() require('flash').treesitter_search() end";
      options.desc = "Treesitter Search";
    }
    {
      mode = "c";
      key = "<C-s>";
      action = mkRaw "function() require('flash').toggle() end";
      options.desc = "Toggle Flash Search";
    }

    {
      mode = "n";
      key = "<leader>db";
      action = "<cmd>Dashboard<CR>";
      options.desc = "[D]ashboard";
    }

    {
      mode = "n";
      key = "<leader>?";
      action = mkRaw "function() require('which-key').show({ global = false }) end";
      options.desc = "Buffer Local Keymaps";
    }
    {
      mode = "n";
      key = "<leader>k";
      action = mkRaw "function() require('which-key').show({ keys = '<leader>', loop = true }) end";
      options.desc = "Keymaps";
    }
  ];

  plugins = {
    "web-devicons".enable = true;

    mini = {
      enable = true;
      modules.pairs = { };
    };

    comment = {
      enable = true;
      settings = {
        padding = true;
        sticky = true;
        ignore = mkRaw "nil";
        mappings = {
          basic = false;
          extra = false;
        };
      };
    };

    ccc = {
      enable = true;
      settings = {
        inputs = [
          "ccc.input.rgb"
          "ccc.input.hsl"
        ];

        outputs = [
          "ccc.output.hex.setup({ uppercase = false })"
          "ccc.output.css_rgb"
          "ccc.output.css_rgba"
          "ccc.output.float"
          "ccc.output.hex_short.setup({ uppercase = false })"
        ];

        highlighter.auto_enable = true;

        convert = [
          [ "ccc.picker.hex" "ccc.output.css_rgb" ]
          [ "ccc.picker.css_rgb" "ccc.output.css_hsl" ]
          [ "ccc.picker.css_hsl" "ccc.output.hex" ]
        ];
      };
    };

    flash.enable = true;

    dashboard = {
      enable = true;
      autoLoad = true;
      settings = {
        theme = "doom";
        config = {
          vertical_center = true;
        header = [ " " ];
          center = [
            {
              desc = "Find File";
              key = "f";
              action = "Telescope find_files";
            }
            {
              desc = "New File";
              key = "n";
              action = "ene | startinsert";
            }
            {
              desc = "Recent Files";
              key = "r";
              action = "Telescope oldfiles";
            }
            {
              desc = "Yazi";
              key = "e";
              action = "Yazi cwd";
            }
          ];
          footer = [
            ""
            "Powered by Nixvim"
          ];
        };
      };
    };

    lualine = {
      enable = true;
      settings = {
        options = {
          icons_enabled = false;
          theme = "auto";
          component_separators = "";
          section_separators = "";
        };

        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];
          lualine_c = [ "filename" ];
          lualine_x = [
            (mkRaw ''
              function()
                local encoding = vim.o.fileencoding
                if encoding == "" then
                  return vim.bo.fileformat .. " :: " .. vim.bo.filetype
                else
                  return encoding .. " :: " .. vim.bo.fileformat .. " :: " .. vim.bo.filetype
                end
              end
            '')
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
    };

    "which-key" = {
      enable = true;
      settings = {
        preset = "helix";

        win = {
          border = "none";
          padding = [ 0 0 0 0 ];
          wo.winblend = 60;
          title = false;
        };

        layout = {
          width = {
            min = 0;
            max = 50;
          };
          height = {
            min = 0;
            max = 25;
          };
        };

        keys = {
          scroll_down = "<Down>";
          scroll_up = "<Up>";
        };

        icons.separator = "::";
        show_help = false;
        show_keys = false;
      };
    };
  };

  extraConfigLuaPost = lib.mkAfter (builtins.readFile ./lua/dashboard.lua);
}
