{ config, pkgs, ... }:

let
  home = config.home.homeDirectory;
  link = config.lib.file.mkOutOfStoreSymlink;
  dot = path: link "${home}/dotfiles/${path}";
in {
  imports = [
    ../fastfetch
    ../yazi
    ../tmux
  ];

  home.packages = with pkgs; [
    antidote
    starship
    fzf
    git
    gh
    zoxide
    ncdu
  ];

  home.file.".zshrc".source = dot "modules/user/shell/.zshrc";
  home.file.".zsh_plugins.txt".source = dot "modules/user/shell/.zsh_plugins.txt";

  home.file.".antidote".source =
    "${pkgs.antidote}/share/antidote";

  xdg.configFile."starship.toml".source =
    dot "modules/user/shell/starship.toml";
}
