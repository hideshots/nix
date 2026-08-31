{ config, pkgs, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  hyprDir = "${config.home.homeDirectory}/dotfiles/modules/user/hyprland";
in {

  imports = [
    ../quickshell
    ../kitty
  ];

  home.packages = with pkgs; [
    # Hyprland helpers
    hyprpicker
    hyprsunset
    hyprfreeze
    hypridle
    wlrctl
    ydotool

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
    "hypr/hyprland.lua".source = link "${hyprDir}/hyprland.lua";
    "hypr/hyprlandd.lua".source = link "${hyprDir}/hyprlandd.lua";
    "hypr/module_lua".source = link "${hyprDir}/module_lua";
    "hypr/hyprland.conf".source = link "${hyprDir}/hyprland.conf";
    "hypr/hyprland_nested.conf".source = link "${hyprDir}/hyprland_nested.conf";
    "hypr/hypridle.conf".source = link "${hyprDir}/hypridle.conf";
    "hypr/modules".source = link "${hyprDir}/modules";
  };

  home.sessionVariables = {
    EWW_PRIMARY_MONITOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GBM_BACKEND = "nvidia-drm";
    NVD_BACKEND = "direct";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    XCURSOR_THEME = "macOS";
    HYPRCURSOR_THEME = "macOS";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
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
