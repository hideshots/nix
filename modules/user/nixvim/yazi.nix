{ ... }:

{
  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Yazi<CR>";
      options.desc = "Open yazi at the current file";
    }
    {
      mode = "n";
      key = "<leader>cw";
      action = "<cmd>Yazi cwd<CR>";
      options.desc = "Open yazi in cwd";
    }
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>Yazi toggle<CR>";
      options.desc = "Resume the last yazi session";
    }
  ];

  plugins.yazi = {
    enable = true;
    settings = {
      open_for_directories = false;
      keymaps.show_help = "<f1>";
      yazi_floating_window_border = "none";
    };
  };
}
