{ config, pkgs, ... }:

let
  home = config.home.homeDirectory;
  link = config.lib.file.mkOutOfStoreSymlink;
  dot = path: link "${home}/dotfiles/${path}";
in {
  programs.fastfetch = {
    enable = true;
  };

  xdg.configFile."fastfetch".source =
    dot "modules/user/fastfetch";
}
