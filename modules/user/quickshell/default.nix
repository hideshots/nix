{ config, pkgs, inputs, lib, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;

  quickshellPkg = inputs.quickshell.packages.${pkgs.system}.default;

  qmlImportPath = lib.concatStringsSep ":" [
    "${quickshellPkg}/lib/qt-6/qml"
    "${pkgs.qt6.qt5compat}/lib/qt-6/qml"
    "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml"
    "${pkgs.qt6.qtwayland}/lib/qt-6/qml"

    "${pkgs.kdePackages.qtsvg}/lib/qt-6/qml"
    "${pkgs.kdePackages.qtimageformats}/lib/qt-6/qml"
    "${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml"
  ];
in {
  qt.enable = true;

  home.packages = with pkgs; [
    quickshellPkg

    qt6.qt5compat
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
  ];

  xdg.configFile."quickshell/default".source =
    link "${home}/dotfiles/modules/user/quickshell/Callista";

  home.sessionVariables = {
    QML_IMPORT_PATH = qmlImportPath;
    QML2_IMPORT_PATH = qmlImportPath;
  };
}
