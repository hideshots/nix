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
      offset = { 0, 15 },
      scale = 0.95,
      color = "rgba(000000ff)",
      color_inactive = "rgba(000000ff)",
    },
    blur = {
      enabled = true,
      ignore_opacity = true,
      special = false,
      -- noise = 0.02,
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
    key_press_enables_dpms = true,
  },
})
