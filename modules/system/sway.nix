{ username, pkgs, ... }:

{
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    xwayland.enable = true;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors.sway = {
      prettyName = "SwayFX";
      comment = "SwayFX compositor managed by UWSM";
      binPath = "${pkgs.swayfx}/bin/sway";
    };
  };

  home-manager.users.${username}.imports = [
    ../user/sway
  ];
}
