{ config, pkgs, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  hyprDir = "${config.home.homeDirectory}/dotfiles/modules/user/hyprland";
in {

  imports = [
    ../quickshell
    ../kitty.nix
  ];

  home.packages = with pkgs; [
    # Hyprland helpers
    hyprpicker
    hyprsunset
    hyprfreeze
    hypridle

    # Screenshots / clipboard / wallpapers
    wl-clipboard
    cliphist
    slurp
    satty
    grim
    jq

    # Launchers / shell
    vicinae
    rofi

    # Apps called directly from binds / exec-once
    mission-center
    brightnessctl
    easyeffects
    pavucontrol
    playerctl
    libnotify
    nautilus

    # Tray / desktop helpers
    kdePackages.plasma-workspace
    networkmanagerapplet
  ];

  xdg.configFile = {
    "hypr/hyprland.conf".source = link "${hyprDir}/hyprland.conf";
    "hypr/hyprland_nested.conf".source = link "${hyprDir}/hyprland_nested.conf";
    "hypr/hypridle.conf".source = link "${hyprDir}/hypridle.conf";
    "hypr/modules".source = link "${hyprDir}/modules";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    systemd = {
      enable = false;
      variables = [ "--all" ];
    };
  };
}
