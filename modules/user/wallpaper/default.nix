{ config, pkgs, ... }:

let
  stateDir = "${config.xdg.stateHome}/waypaper";
  configFile = "${stateDir}/config.ini";

  waypaperWrapped = pkgs.writeShellScriptBin "waypaper" ''
    set -euo pipefail

    mkdir -p "${stateDir}"

    if [ ! -f "${configFile}" ]; then
      printf '%s\n' \
        '[Settings]' \
        'post_command = $HOME/.local/bin/pywal_update.sh "$wallpaper"' \
        > "${configFile}"
    fi

    exec ${pkgs.waypaper}/bin/waypaper --config-file "${configFile}" "$@"
  '';
in
{
  imports = [
    ../pywal
  ];
  home.packages = [
    pkgs.swww
    waypaperWrapped
  ];
}
