{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;

    settings = {
      font_family = "family=\"SF Pro Mono\"";
      font_size = "14.0";
      shell_integration = "enabled";
      term = "xterm-kitty";
      map_timeout = "1.2";

      tab_title_template = "{index}:{session_name} {title}";
      enabled_layouts = "splits,tall,fat,grid,stack,horizontal,vertical";
      tab_switch_strategy = "previous";
      tab_bar_style = "powerline";

      cursor_trail = 1;
      cursor_trail_start_threshold = 1;
      cursor_trail_decay = "0.01 0.20";
      cursor_beam_thickness = "2.0";
      cursor_shape = "beam";

      confirm_os_window_close = 0;
      hide_window_decorations = 1;
      scrollback_lines = 10000;
      enable_audio_bell = "no";
      bell_on_tab = "none";

      background_opacity = "0.5";
      dynamic_background_opacity = "yes";
    };

    keybindings = {
      "ctrl+b>space" = "next_layout";
      "ctrl+b>z" = "toggle_layout stack";
      "ctrl+b>alt+1" = "goto_layout horizontal";
      "ctrl+b>alt+2" = "goto_layout vertical";
      "ctrl+b>alt+3" = "goto_layout fat";
      "ctrl+b>alt+4" = "goto_layout tall";
      "ctrl+b>alt+5" = "goto_layout grid";
      "ctrl+b>alt+6" = "goto_layout fat:mirrored=true";
      "ctrl+b>alt+7" = "goto_layout tall:mirrored=true";
      "ctrl+b>=" = "reset_window_sizes";

      "ctrl+b>c" = "new_tab_with_cwd";
      "ctrl+b>n" = "next_tab";
      "ctrl+b>p" = "previous_tab";
      "ctrl+b>w" = "select_tab";
      "ctrl+b>," = "set_tab_title \" \"";
      "ctrl+b>shift+w" = "close_tab";
      "ctrl+b>1" = "goto_tab 1";
      "ctrl+b>2" = "goto_tab 2";
      "ctrl+b>3" = "goto_tab 3";
      "ctrl+b>4" = "goto_tab 4";
      "ctrl+b>5" = "goto_tab 5";
      "ctrl+b>6" = "goto_tab 6";
      "ctrl+b>7" = "goto_tab 7";
      "ctrl+b>8" = "goto_tab 8";
      "ctrl+b>9" = "goto_tab 9";
      "ctrl+b>0" = "goto_tab 10";

      "ctrl+b>enter" = "new_window_with_cwd";
      "ctrl+b>'" = "launch --location=vsplit --cwd=current";
      "ctrl+b>%" = "launch --location=hsplit --cwd=current";

      "ctrl+b>h" = "neighboring_window left";
      "ctrl+b>j" = "neighboring_window bottom";
      "ctrl+b>k" = "neighboring_window top";
      "ctrl+b>l" = "neighboring_window right";
      "ctrl+b>left" = "neighboring_window left";
      "ctrl+b>down" = "neighboring_window bottom";
      "ctrl+b>up" = "neighboring_window top";
      "ctrl+b>right" = "neighboring_window right";

      "ctrl+b>o" = "next_window";
      "ctrl+b>;" = "nth_window -1";
      "ctrl+b>q" = "focus_visible_window";
      "ctrl+b>x" = "close_window";
      "ctrl+b>." = "set_window_title \" \"";

      "ctrl+b>shift+h" = "move_window left";
      "ctrl+b>shift+j" = "move_window bottom";
      "ctrl+b>shift+k" = "move_window top";
      "ctrl+b>shift+l" = "move_window right";

      "ctrl+b>ctrl+left" = "resize_window narrower";
      "ctrl+b>ctrl+right" = "resize_window wider";
      "ctrl+b>ctrl+up" = "resize_window taller";
      "ctrl+b>ctrl+down" = "resize_window shorter";

      "ctrl+b>alt+left" = "resize_window narrower 5";
      "ctrl+b>alt+right" = "resize_window wider 5";
      "ctrl+b>alt+up" = "resize_window taller 5";
      "ctrl+b>alt+down" = "resize_window shorter 5";

      "ctrl+b>/" = "goto_session ~/.local/share/kitty/sessions";
      "ctrl+b>shift+s" = "save_as_session --use-foreground-process --base-dir ~/.local/share/kitty/sessions";
      "ctrl+b>a" = "save_as_session --relocatable --use-foreground-process --match=session:. .";
      "ctrl+b>d" = "detach_tab";
      "ctrl+b>shift+d" = "detach_window";
      "ctrl+b>shift+q" = "close_session .";

      "ctrl+b>[" = "show_scrollback";
      "ctrl+b>]" = "paste_from_clipboard";
      "ctrl+b>f" = "search_scrollback";
      "ctrl+b>g" = "show_last_command_output";

      "ctrl+b>shift+c" = "edit_config_file";
      "ctrl+b>r" = "load_config_file";
      "ctrl+b>shift+p" = "command_palette";
      "ctrl+b>:" = "kitty_shell";
      "ctrl+b>?" = "show_kitty_doc conf";
    };

    extraConfig = ''
      include ~/.cache/wal/colors-kitty.conf

      background_opacity 0.5
      dynamic_background_opacity yes

      background #000000
      foreground #c1c1c1
      selection_background #c1c1c1
      selection_foreground #000000
      url_color #999999
      cursor #c1c1c1
      active_border_color #333333
      inactive_border_color #121212
      active_tab_background #000000
      active_tab_foreground #c1c1c1
      inactive_tab_background #121212
      inactive_tab_foreground #999999
      tab_bar_background #121212
    '';
  };
}
