{ config, pkgs, ... }:

let
  script = "${config.home.homeDirectory}/.local/bin/pywal_update.sh";
in
{
  home.packages = with pkgs; [
    waypaper
    pywal
    swww
  ];

  home.file.".local/bin/pywal_update.sh" = {
    source = ./pywal_update.sh;
    executable = true;
  };

  xdg.configFile."waypaper/config.ini".text = ''
    [Settings]
    language = en
    folder = /mnt/hdd/Pictures/Wallpapers
    monitors = All
    wallpaper = /mnt/hdd/Pictures/Wallpapers/287634.jpg
    show_path_in_tooltip = True
    backend = swww
    fill = fill
    sort = date
    color = #ffffff
    subfolders = True
    all_subfolders = False
    show_hidden = True
    show_gifs_only = False
    zen_mode = False
    post_command = ${script} "$wallpaper"
    number_of_columns = 3
    swww_transition_type = none
    swww_transition_step = 63
    swww_transition_angle = 0
    swww_transition_duration = 1
    swww_transition_fps = 800
    mpvpaper_sound = False
    mpvpaper_options =
    use_xdg_state = True
  '';
}
