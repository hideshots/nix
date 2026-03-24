{ pkgs, ... }:

{
  home.username = "drama";
  home.homeDirectory = "/home/drama";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fastfetch
    lazygit
    ripgrep
    tree
    fd
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
