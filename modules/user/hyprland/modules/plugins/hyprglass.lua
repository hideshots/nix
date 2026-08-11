if hl.plugin.hyprglass == nil then
  return false
end

local config = {
  enabled = true,
  manage_window_blur = true,
  default_theme = "dark",
  default_preset = "default",
  layers = {
    enabled = true,
  },
}

local presets = {
  default = {
    inherits = "default",
    blur_strength = 0.34,
    blur_iterations = 4,
    refraction_strength = 0.5,
    chromatic_aberration = 0.02,
    fresnel_strength = 0.25,
    specular_strength = 0.0,
    glass_opacity = 1.0,
    edge_thickness = 0.015,
    tint_color = 0x00000000,
    lens_distortion = 0.8,
    dark = {
      brightness = 1.0,
      contrast = 1.0,
      saturation = 1.4,
      vibrancy = 0.15,
      vibrancy_darkness = 0.0,
      adaptive_dim = 0.0,
      adaptive_boost = 0.0,
    },
    light = {
      brightness = 1.12,
      contrast = 0.92,
      saturation = 0.85,
      vibrancy = 0.12,
      vibrancy_darkness = 0.0,
      adaptive_dim = 0.0,
      adaptive_boost = 0.4,
    },
  },
  menus = {
    inherits = "default",
    blur_strength = 1.0,
    blur_iterations = 1,
    refraction_strength = 1.0,
    chromatic_aberration = 0.00,
    fresnel_strength = 0.0,
    specular_strength = 3.0,
    glass_opacity = 1.0,
    edge_thickness = 0.020,
    tint_color = 0xffffff0d,
    lens_distortion = 2,
    dark = {
      brightness = 1.0,
      contrast = 1.0,
      saturation = 1.0,
      vibrancy = 0.0,
      vibrancy_darkness = 0.0,
      adaptive_dim = 0.3,
      adaptive_boost = 0.0,
    },
    light = {
      brightness = 1.06,
      contrast = 0.95,
      saturation = 0.9,
      vibrancy = 0.16,
      vibrancy_darkness = 0.0,
      adaptive_dim = 0.0,
      adaptive_boost = 0.3,
    },
  },
  clear = {
    inherits = "default",
    glass_opacity = 1.0,
    blur_strength = 0.9,
    blur_iterations = 2,
    refraction_strength = 1.6,
    chromatic_aberration = 0.05,
    -- fresnel_strength = 1.3,
    -- specular_strength = 1.7,
    edge_thickness = 0.08,
    tint_color = 0xffffff0d,
    lens_distortion = 9.0,
    dark = {
      brightness = 1.0,
      contrast = 1.0,
      saturation = 1.2,
      vibrancy = 1.0,
      vibrancy_darkness = 0.0,
      adaptive_dim = 0.0,
      adaptive_boost = 0.0,
    },
    light = {
      brightness = 1.0,
      contrast = 1.0,
      saturation = 1.0,
      vibrancy = 0.0,
      vibrancy_darkness = 0.0,
      adaptive_dim = 0.0,
      adaptive_boost = 0.0,
    },
  },
  darken = {
    inherits = "default",
    blur_strength = 1,
    blur_iterations = 2,
    refraction_strength = 1.0,
    chromatic_aberration = 0.02,
    fresnel_strength = 0.0,
    specular_strength = 0.0,
    glass_opacity = 1.0,
    edge_thickness = 0.015,
    tint_color = 0x00000000,
    lens_distortion = 0.2,
    dark = {
      brightness = 0.2,
      contrast = 1.0,
      saturation = 1.3,
      vibrancy = 0.0,
      vibrancy_darkness = 0.0,
      adaptive_dim = 0.2,
      adaptive_boost = 0.0,
    },
    light = {
      brightness = 0.55,
      contrast = 1.0,
      saturation = 1.0,
      vibrancy = 0.0,
      vibrancy_darkness = 1.0,
      adaptive_dim = 0.8,
      adaptive_boost = 0.0,
    },
  },
}

local layers = {
  {
    name = "quickshell:control-center-empty-slot",
    exclude = true,
  },
  {
    name = "quickshell:control-center-tile-1x1",
    preset = "clear",
    mask_threshold = 0.1,
    rounding  = 100,
  },
  {
    name = "quickshell:control-center-tile-2x1",
    preset = "clear",
    mask_threshold = 0.1,
    rounding  = 100,
  },
  {
    name = "quickshell:control-center-tile-2x2",
    preset = "clear",
    mask_threshold = 0.1,
    rounding  = 35,
  },
  {
    name = "quickshell:control-center-tile-4x1",
    preset = "clear",
    mask_threshold = 0.1,
    rounding = 25,
  },
  {
    name = "quickshell:control-center-footer",
    preset = "clear",
    mask_threshold = 0.1,
    rounding = 100,
  },
  {
    name = "quickshell:control-center-privacy",
    preset = "clear",
    mask_threshold = 0.1,
    rounding = 20,
  },
  {
    name = "quickshell:osd",
    preset = "clear",
    mask_threshold = 0.1,
    rounding = 20,
  },
  {
    name = "quickshell:desktop-widget-(calendar|weather):.*",
    preset = "clear",
    mask_threshold = 0.0,
  },
  {
    name = "quickshell:menu",
    preset = "menus",
    mask_threshold = 0.0,
    rounding = 15,
    no_anim = true,
  },
  {
    name = "quickshell:notification-popup-backdrop",
    preset = "clear",
    mask_threshold = 0.01,
    rounding = 15,
  },
  {
    name = "quickshell:notification-center",
    preset = "clear",
    mask_threshold = 0.01,
  },
  {
    name = "quickshell:notification-actions",
    preset = "clear",
    mask_threshold = 0.1,
  },
  {
    name = "quickshell:notification-dismiss",
    preset = "clear",
    mask_threshold = 0.1,
  },
}

local function setup()
  local hg = hl.plugin.hyprglass

  if hg == nil then
    return
  end

  hg.config(config)

  hg.preset("default", presets.default)
  hg.preset("menus", presets.menus)
  hg.preset("clear", presets.clear)
  hg.preset("darken", presets.darken)

  for _, layer in ipairs(layers) do
    local layer_cfg = {
      preset = layer.preset,
      mask_threshold = layer.mask_threshold,
      rounding = layer.rounding,
      exclude = layer.exclude,
    }

    hg.layer(layer.name, layer_cfg)
  end

  -- Per-window rules
  hl.window_rule({
    name = "kitty-hyprglass",
    match = { class = "^kitty(-.*)?$" },
    tag = "+hyprglass_preset_darken",
  })
end

return {
  config = config,
  setup = setup,
}
