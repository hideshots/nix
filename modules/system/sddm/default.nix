{ pkgs, ... }:

let
  opalineSddmTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "opaline-sddm-theme";
    version = "1.0";
    src = ./Opaline;

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      themeDir="$out/share/sddm/themes/Opaline"
      mkdir -p "$themeDir"

      cp Main.qml "$themeDir/"
      cp metadata.desktop "$themeDir/"
      cp theme.conf "$themeDir/"
      cp -r components "$themeDir/"
      cp -r shaders "$themeDir/"

      runHook postInstall
    '';
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "Opaline";

    extraPackages = with pkgs; [
    ];
  };

  environment.systemPackages = [
    opalineSddmTheme
  ];
}
