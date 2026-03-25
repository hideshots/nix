{ config, pkgs, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  hyprDir = "${config.home.homeDirectory}/dotfiles/modules/user/hyprland";
in {
  home.packages = with pkgs; [
    hypridle
    hyprpicker
    hyprsunset

    grim
    slurp
    satty
    jq

    wl-clipboard
    cliphist

    swww
    waypaper
  ];

  xdg.configFile = {
    "hypr/hyprland.conf".source = link "${hyprDir}/hyprland.conf";
    "hypr/hyprland_nested.conf".source = link "${hyprDir}/hyprland_nested.conf";
    "hypr/hypridle.conf".source = link "${hyprDir}/hypridle.conf";

    # Symlink the whole modules directory as one directory link.
    # Do not use recursive + mkOutOfStoreSymlink here.
    "hypr/modules".source = link "${hyprDir}/modules";
  };
}
