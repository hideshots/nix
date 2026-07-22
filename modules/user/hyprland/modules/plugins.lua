hl.permission({
  binary = "/usr/(bin|local/bin)/hyprpm",
  type = "plugin",
  mode = "allow",
})

if hl.plugin.darkwindow ~= nil then
  hl.plugin.darkwindow.load_shader("blackKey", {
    from = "chromakey",
    args = "bkg=[0 0 0] similarity=0.001 amount=1.4 targetOpacity=0.8",
    introduces_transparency = true,
  })
end

hl.config { plugin = {
  borders_plus_plus = {
    add_borders = 1,
    natural_rounding = true,
    col = {
      border_1 = "rgb(000000)",
    },
    border_size_1 = 1,
  },
  dynamic_cursors = {
    enabled = true,
    mode = "tilt",
    threshold = 2,
    stretch = {
        limit = 3000,
        activation = "quadratic",
        window = 100,
    },
    tilt = {
      limit = 5000,
      activation = "negative_quadratic",
      window = 150,
      full = 85,
    },
    shake = {
      enabled = false,
      threshold = 6.0,
      base = 1.0,
      speed = 3.0,
      influence = 1.0,
      limit = 30.0,
      timeout = 2000,
      effects = false,
      ipc = false,
    },
    hyprcursor = {
      nearest = 1,
      enabled = true,
      resolution = 512,
      fallback = "clientside",
    },
  },
  darkwindow = {
    load_shaders = "all",
  },
} }
