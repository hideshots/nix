{ pkgs, ... }:

{
  imports = [
    ../../modules/user/fastfetch.nix
    ../../modules/user/shell.nix
    ../../modules/user/yazi.nix
    ../../modules/user/toolchain
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
