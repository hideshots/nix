local main_mod = Config.main_mod
local terminal = Config.terminal

hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd(terminal .. " --override background_opacity=0"))

hl.config({
  decoration = {
    rounding = 6,
    dim_special = 0.45,
    blur = {
      enabled = true,
      ignore_opacity = true,
      special = false,
      noise = 0.015,
      size = 3,
      passes = 1,
      xray = false,
      popups = true,
      popups_ignorealpha = 0.2,
      glass_lensing = 20,
      glass_edge_softness = 0,
      glass_dimming = 0.0,
      glass_tint_strength = 0.0,
      glass_specular_strength = 0,
      glass_light_strength = 0.2,
      glass_shadow_strength = 0.1,
      glass_ambient_strength = 0.0,
      brightness = 1.0,
      vibrancy = 0.1,
      vibrancy_darkness = 1,
    },
  },
})
