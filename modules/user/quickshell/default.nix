{ config, pkgs, inputs, lib, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
in {
  home.packages =
    [
      inputs.quickshell.packages.${pkgs.system}.default
    ]
    ++ (with pkgs; [
      kdePackages.qt5compat
      kdePackages.qtsvg
      kdePackages.qtimageformats
      kdePackages.qtmultimedia

      playerctl
      brightnessctl
      ddcutil
      curl
      hyprsunset
      vicinae
      bluez
      networkmanager
    ]);

  xdg.configFile."quickshell/default".source =
    link "${home}/dotfiles/modules/user/quickshell/Callista";

  home.sessionVariables.QML2_IMPORT_PATH =
    lib.makeSearchPath "lib/qt-6/qml" [
      pkgs.kdePackages.qt5compat
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtimageformats
      pkgs.kdePackages.qtmultimedia
    ];
}
