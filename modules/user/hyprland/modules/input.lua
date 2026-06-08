hl.config({
  input = {
    kb_layout = "us,ru",
    kb_variant = "",
    kb_model = "",
    kb_options = "grp:win_space_toggle,ctrl:nocaps",
    kb_rules = "",
    follow_mouse = 0,
    float_switch_override_focus = 0,
    accel_profile = "flat",
    force_no_accel = true,
    sensitivity = 0.0,
    scroll_button = 1,
    natural_scroll = true,
    touchpad = {
      disable_while_typing = false,
      scroll_factor = 1.0,
      tap_button_map = "lrm",
      clickfinger_behavior = false,
      tap_to_click = true,
      drag_lock = false,
      tap_and_drag = true,
      flip_x = false,
      flip_y = false,
    },
  },
  cursor = {
    zoom_disable_aa = true,
  },
})

for _, name in ipairs({
  "touch-passthrough",
  "touch-passthrough-1",
  "mouse-passthrough",
  "kingston-hyperx-pulsefire-surge",
  "kingston-hyperx-pulsefire-surge-keyboard",
  "kingston-hyperx-pulsefire-surge-keyboard-1",
  "mouse-passthrough-(absolute)",
  "keyboard-passthrough",
}) do
  hl.device({ name = name, enabled = false })
end
