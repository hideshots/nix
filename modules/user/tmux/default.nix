{ config, pkgs, ... }:

let
  home = config.home.homeDirectory;
  link = config.lib.file.mkOutOfStoreSymlink;
  dot = path: link "${home}/dotfiles/${path}";
in {
  home.packages = with pkgs; [
    tmux
    fzf
  ];

  home.file.".tmux.conf".source = dot "modules/user/tmux/.tmux.conf";
}
