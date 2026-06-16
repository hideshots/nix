hl.monitor({
  output = "DP-1",
  mode = "1920x1080@239.96",
  position = "1920x0",
  scale = 1,
  bitdepth = 10,
  supports_hdr = 0,
  supports_wide_color = 1,
  disabled = false,
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

hl.monitor({ output = "Virtual-1", mode = "1920x1048@540", position = "0x0", scale = 1, disabled = true})
hl.monitor({ output = "WAYLAND-1", mode = "preferred", position = "auto", scale = 1, disabled = true})

hl.config({
  render = {
    cm_enabled = true,
    send_content_type = true,
    cm_auto_hdr = 2,
  },
  cursor = {
    default_monitor = "DP-1",
    no_hardware_cursors = true,
    no_break_fs_vrr = 1,
    no_warps = false,
  },
})

for i = 1, 10 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", layout = "scrolling" })
end

hl.workspace_rule({ workspace = "11", monitor = "HDMI-A-1", layout = "monocle" })
hl.workspace_rule({ workspace = "12", monitor = "HDMI-A-2", layout = "monocle" })
