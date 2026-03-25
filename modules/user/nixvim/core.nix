{ pkgs, ... }:

{
  enable = true;
  viAlias = true;
  vimAlias = true;
  waylandSupport = true;
  impureRtp = false;

  globals = {
    mapleader = " ";
    maplocalleader = ",";
  };

  opts = {
    undofile = true;
    number = true;
    relativenumber = true;
    clipboard = "unnamedplus";

    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;
    smartindent = true;
    smarttab = true;

    scrolloff = 8;
    sidescrolloff = 8;
    mouse = "a";
    whichwrap = "bs<>[]hl";

    termguicolors = true;
    background = "dark";
    errorbells = false;

    timeout = true;
    timeoutlen = 300;
  };

  colorscheme = "lackluster";

  extraPackages = with pkgs; [
    git
    ripgrep
    fd
    fzf
    zoxide
    yazi
    wl-clipboard
  ];

  extraPlugins = with pkgs.vimPlugins; [
    friendly-snippets
    lackluster-nvim
    tabout-nvim
    telescope-fzf-native-nvim
    telescope-ui-select-nvim
    telescope-zoxide
  ];
}
