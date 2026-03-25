{ lib, ... }:

let
  mkRaw = lib.nixvim.mkRaw;
in
{
  keymaps = [
    {
      mode = [ "n" "t" ];
      key = "<M-h>";
      action = "<cmd>ToggleTerm<CR>";
      options.desc = "Toggle Terminal";
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>ToggleTerm direction=float<CR>";
      options.desc = "Float Terminal";
    }
    {
      mode = "n";
      key = "<leader>th";
      action = "<cmd>ToggleTerm direction=horizontal<CR>";
      options.desc = "Horizontal Terminal";
    }
    {
      mode = "n";
      key = "<leader>tv";
      action = "<cmd>ToggleTerm direction=vertical size=80<CR>";
      options.desc = "Vertical Terminal";
    }
  ];

  plugins.toggleterm = {
    enable = true;
    settings = {
      size = 15;
      hide_numbers = true;
      shade_terminals = true;
      shading_factor = 2;
      start_in_insert = true;
      insert_mappings = true;
      persist_size = true;
      direction = "horizontal";
      close_on_exit = true;
      auto_scroll = true;

      float_opts = {
        border = "curved";
        winblend = 0;
        highlights = {
          border = "Normal";
          background = "Normal";
        };
      };

      on_open = mkRaw ''
        function()
          vim.cmd("startinsert!")
        end
      '';

      on_close = mkRaw ''
        function()
          vim.cmd("startinsert!")
        end
      '';
    };
  };

  extraConfigLuaPost = lib.mkAfter ''
    ${builtins.readFile ./lua/tabout.lua}
    ${builtins.readFile ./lua/terminal.lua}
  '';
}
