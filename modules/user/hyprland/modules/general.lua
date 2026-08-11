hl.config({
  general = {
    gaps_in = 3,
    gaps_out = { top = 5, right = 10, bottom = 10, left = 10 },
    border_size = 1,
    col = {
      active_border = "rgba(59595Bff)",
      inactive_border = "rgba(59595Bff)",
    },
    resize_on_border = true,
    allow_tearing = true,
    layout = "dwindle",
  },
  decoration = {
    rounding = 8,
    dim_special = 0.2,
    shadow = {
      enabled = true,
      range = 110,
      render_power = 3,
      offset = { 0, 10 },
      scale = 0.95,
      color = "rgba(000000a3)",
      color_inactive = "rgba(0000009f)",
    },
    blur = {
      enabled = true,
      ignore_opacity = true,
      special = false,
      noise = 0.0,
      size = 2,
      passes = 2,
      xray = false,
      popups = true,
      popups_ignorealpha = 0.2,
      vibrancy = 0.07,
      vibrancy_darkness = 1,
    },
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    new_status = "master",
  },
  misc = {
    layers_hog_keyboard_focus = false,
    key_press_enables_dpms = true,
  },
  group = {
    drag_into_group = 2,
    col = {
      border_active = "rgba(59595Bff)",
      border_inactive = "rgba(59595Bff)",
      border_locked_active = "rgba(59595Bff)",
      border_locked_inactive = "rgba(59595Bff)",
    },

    groupbar = {
      font_size = 0,
      height = -4,
      indicator_gap = 0,
      indicator_height = 2,
      rounding = 9,
      rounding_power = 1,
      gaps_out = 1,
      col = {
        active = "rgba(ffffff90)",
        inactive = "rgba(00000000)",
        locked_active = "rgba(59595Bff)",
        locked_inactive = "rgba(00000000)",
      },
    },
  },
})
