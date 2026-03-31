{ pkgs, inputs, username, ... }:

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
    inputs.helium.packages.${system}.default

    lazygit
    ripgrep
    tree
    fd
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";
}
