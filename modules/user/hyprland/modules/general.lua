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
    rounding = 7,
    dim_special = 0.45,
    shadow = {
      enabled = true,
      range = 70,
      render_power = 3,
      offset = { 0, 9 },
      scale = 1.0,
      color = "rgba(00000033)",
      color_inactive = "rgba(00000024)",
    },
    blur = {
      enabled = true,
      ignore_opacity = true,
      special = true,
      noise = 0.02,
      size = 2,
      passes = 3,
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
    key_press_enables_dpms = true,
  },
})
