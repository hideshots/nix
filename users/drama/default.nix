{ config, pkgs, inputs, username, ... }:

let
  homeDir = config.home.homeDirectory;
  link = config.lib.file.mkOutOfStoreSymlink;
  dot = path: link "${homeDir}/dotfiles/${path}";
  system = pkgs.stdenv.hostPlatform.system;
in {
  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    inputs.home-manager.packages.${system}.home-manager
    inputs.apple-fonts.packages.${system}.sf-pro
    nerd-fonts.iosevka
    terminus_font
    nix
  ];

  home.file = {
    ".zshrc".source = dot "modules/user/shell/.zshrc";
    ".zsh_plugins.txt".source = dot "modules/user/shell/.zsh_plugins.txt";
    ".antidote".source = "${pkgs.antidote}/share/antidote";
    ".tmux.conf".source = dot "modules/user/tmux/.tmux.conf";
    ".local/bin/pywal_update.sh" = {
      source = dot "modules/user/pywal/pywal_update.sh";
    };
  };

  xdg.configFile = {
    "starship.toml".source = dot "modules/user/shell/starship.toml";
    "fastfetch".source = dot "modules/user/fastfetch";
    "kitty".source = dot "modules/user/kitty";
    "nvim".source = dot "modules/user/neovim";
    "yazi".source = dot "modules/user/yazi";
    "hypr".source = dot "modules/user/hyprland";
    "sway/config".source = dot "modules/user/sway/config";
    "i3status".source = dot "modules/user/sway/i3status";
    "quickshell/default".source = dot "modules/user/quickshell/Callista";
    "MangoHud/MangoHud.conf".source = dot "modules/user/mangohud/MangoHud.conf";
    "wal/templates/mayhem.toml".source = dot "modules/user/vicinae/mayhem.toml";
  };
}
