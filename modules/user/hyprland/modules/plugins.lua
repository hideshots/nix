hl.permission({
  binary = "/usr/(bin|local/bin)/hyprpm",
  type = "plugin",
  mode = "allow",
})

hl.bind("SUPER + UP", hl.plugin.hymission.toggle)

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
    rotate = {
      length = 20,
      offset = 0.0,
    },
    tilt = {
      limit = 5000,
      activation = "negative_quadratic",
      window = 100,
      full = 65,
    },
    shake = {
      enabled = true,
      threshold = 6.0,
      base = 1.0,
      speed = 1.0,
      influence = 1.0,
      limit = 10.0,
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
