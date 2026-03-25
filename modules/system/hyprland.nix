{ username, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  home-manager.users.${username}.imports = [
    ../user/hyprland
  ];
}
