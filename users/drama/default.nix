{ pkgs, ... }:

{
  imports = [
    ../../modules/user/shell
    ../../modules/user/kitty
    ../../modules/user/toolchain
    ../../modules/user/wallpaper
    ../../modules/user/neovim
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fastfetch
    lazygit
    ripgrep
    tree
    fd
  ];

  home.username = "drama";
  home.homeDirectory = "/home/drama";
  home.stateVersion = "25.11";
}
