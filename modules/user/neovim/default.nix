{ config, pkgs, lib, ... }:

let
  home = config.home.homeDirectory;
  link = path: config.lib.file.mkOutOfStoreSymlink path;
in {
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      git
      curl
      unzip

      wl-clipboard
      xclip

      yazi
      zoxide

      tree-sitter
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };

  xdg.configFile."nvim".source =
    link "${home}/dotfiles/modules/user/neovim";
}
