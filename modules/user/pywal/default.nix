{ config, pkgs, lib, ... }:

let
  home = config.home.homeDirectory;
  walCache = "${home}/.cache/wal";
in
{
  home.packages = with pkgs; [
    pywal
  ];

  home.file.".local/bin/pywal_update.sh" = {
    source = ./pywal_update.sh;
    executable = true;
  };

  home.activation.restoreWal = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -f "${walCache}/colors.json" ]; then
      ${pkgs.pywal}/bin/wal -R -q || true
    fi
  '';
}
