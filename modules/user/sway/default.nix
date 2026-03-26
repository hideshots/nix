{ config, pkgs, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  swayDir = "${config.home.homeDirectory}/dotfiles/modules/user/sway";
in {
  imports = [
    ../kitty.nix
  ];

  home.packages = with pkgs; [
    bemenu
    mako
    i3status

    grim
    slurp
    swappy
    wl-clipboard

    swww
    networkmanagerapplet

    pavucontrol
    brightnessctl
    playerctl
    glib

    wl-kbptr
  ];

  xdg.configFile = {
    "sway/config".source = link "${swayDir}/config";
    "i3status/config".source = link "${swayDir}/i3status/config";
    "i3status/scripts".source = link "${swayDir}/i3status/scripts";
  };
}
