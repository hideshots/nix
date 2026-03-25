{ pkgs, ... }:

let
  tahoeSddmTheme = pkgs.stdenvNoCC.mkDerivation {
    pname = "tahoe-sddm-theme";
    version = "1.0";
    src = ./.;

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      themeDir="$out/share/sddm/themes/tahoe"
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
    theme = "${tahoeSddmTheme}/share/sddm/themes/tahoe";

    extraPackages = with pkgs; [
      # add packages here only if SDDM logs show missing QML/Qt modules
    ];
  };

  environment.systemPackages = [
    tahoeSddmTheme
  ];
}
