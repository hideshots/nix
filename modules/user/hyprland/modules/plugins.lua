hl.permission({
  binary = "/usr/(bin|local/bin)/hyprpm",
  type = "plugin",
  mode = "allow",
})

hl.bind("SUPER + UP", hl.plugin.hymission.toggle)

hl.config { plugin = {
  borders_plus_plus = {
    add_borders = 1,
    natural_rounding = true,
    col = {
      border_1 = "rgb(000000)",
    },
    border_size_1 = 1,
  },
  hymission = {
    -- Layout
    layout_engine = "grid",
    outer_padding_top = 92,
    outer_padding_right = 32,
    outer_padding_bottom = 32,
    outer_padding_left = 32,
    row_spacing = 32,
    column_spacing = 32,
    min_window_length = 120,
    min_preview_short_edge = 32,
    small_window_boost = 1.35,
    max_preview_scale = 0.95,
    workspace_overview_max_preview_scale = 0.95,
    min_slot_scale = 0.10,
    natural_scale_flex = 0.22,
    layout_scale_weight = 1.0,
    layout_space_weight = 0.10,
    one_workspace_per_row = 0,

    -- Behavior
    expand_selected_window = 1,
    overview_focus_follows_mouse = 1,
    multi_workspace_sort_recent_first = 1,
    toggle_switch_mode = 1,
    switch_toggle_auto_next = 1,
    switch_release_key = "Super_L",
    gesture_invert_vertical = 0,
    only_active_workspace = 0,
    only_active_monitor = 0,
    show_special = 0,
    workspace_change_keeps_overview = 1,

    -- Workspace strip
    workspace_strip_anchor = "top",
    workspace_strip_empty_mode = "existing",
    workspace_strip_thickness = 160,
    workspace_strip_gap = 24,
    hide_bar_when_strip = 1,
    hide_bar_animation = 1,
    hide_bar_animation_blur = 1,
    hide_bar_animation_move_multiplier = 0.8,
    hide_bar_animation_scale_divisor = 1.1,
    hide_bar_animation_alpha_end = 0,
    bar_single_mission_control = 0,
    show_focus_indicator = 0,

    -- Debug
    debug_logs = 0,
    debug_surface_logs = 0,
  },
  dynamic_cursors = {

    enabled = true,
    mode = "tilt",
    threshold = 2,
    rotate = {
      length = 20,
      offset = 0.0,
    },
    tilt = {
      limit = 5000,
      activation = "negative_quadratic",
      window = 100,
      full = 45,
    },
    shake = {
      enabled = true,
      threshold = 9.0,
      base = 14.0,
      speed = 4.0,
      influence = 0.0,
      limit = 0.0,
      timeout = 2000,
      effects = false,
      ipc = false,
    },
    hyprcursor = {
      nearest = 1,
      enabled = true,
      resolution = -1,
      fallback = "clientside",
    },
  } } }
