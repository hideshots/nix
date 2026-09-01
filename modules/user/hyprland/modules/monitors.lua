hl.monitor({
  output = "DP-1",
  mode = "1920x1080@239.96",
  position = "1920x0",
  vrr = 0,
  scale = 1,
  bitdepth = 10,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@143.98",
  position = "0x0",
  scale = 1,
  disabled = false,
})

hl.monitor({
  output = "HDMI-A-2",
  mode = "1920x1080@60",
  position = "3840x0",
  scale = 1,
  disabled = false,
})

hl.monitor({ output = "Virtual-1", mode = "1920x1048@540", position = "0x0", scale = 1, disabled = false})
hl.monitor({ output = "WAYLAND-1", mode = "preferred", position = "auto", scale = 1, disabled = false})

hl.config({
  render = {
    send_content_type = false,
    direct_scanout = 2,
    expand_undersized_textures = true,

    cm_enabled = true,
    cm_auto_hdr = 0,
    ctm_animation = 0,
  },
  cursor = {
    default_monitor = "DP-1",
    no_hardware_cursors = 0,
    use_cpu_buffer = 2,
    no_break_fs_vrr = 1,
    min_refresh_rate = 48,
    no_warps = false,
  },
  misc = {
    layers_hog_keyboard_focus = false,
    key_press_enables_dpms = true,
  },
})

for i = 1, 10 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", layout = "scrolling" })
end

hl.workspace_rule({ workspace = "11", monitor = "HDMI-A-1", layout = "monocle" })
hl.workspace_rule({ workspace = "12", monitor = "HDMI-A-2", layout = "monocle" })
