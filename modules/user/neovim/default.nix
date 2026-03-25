{ config, ... }:

let
  home = config.home.homeDirectory;
  link = path: config.lib.file.mkOutOfStoreSymlink path;
in {
  xdg.configFile."nvim".source =
    link "${home}/dotfiles/modules/user/neovim";
}
