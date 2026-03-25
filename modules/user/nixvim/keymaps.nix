{ lib, ... }:

let
  mkRaw = lib.nixvim.mkRaw;
in
{
  keymaps = [
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
      options.desc = "Clear search highlighting";
    }

    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>bprevious<CR>";
      options.desc = "Previous buffer";
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>bnext<CR>";
      options.desc = "Next buffer";
    }

    {
      mode = "v";
      key = "<";
      action = "<gv";
      options.desc = "Decrease indent";
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
      options.desc = "Increase indent";
    }

    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move text down";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move text up";
    }

    {
      mode = "n";
      key = "<leader>/";
      action = mkRaw "function() require('Comment.api').toggle.linewise.current() end";
      options = {
        desc = "Toggle comment on current line";
        silent = true;
      };
    }

    {
      mode = "x";
      key = "<leader>/";
      action = mkRaw ''
        function()
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes('<ESC>', true, false, true),
            'nx',
            false
          )
          require('Comment.api').toggle.linewise(vim.fn.visualmode())
        end
      '';
      options = {
        desc = "Toggle line comment on selected lines";
        silent = true;
      };
    }
  ];
}
