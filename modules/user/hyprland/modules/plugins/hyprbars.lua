if hl.plugin.hyprbars == nil then
  return false
end

local buttons = {
  {
    bg_color = "rgb(ff5c5f)",
    fg_color = "rgb(000000)",
    size = 14,
    icon = "",
    action = "hyprctl dispatch 'hl.dsp.window.close()'",
  },
  {
    bg_color = "rgb(febc2e)",
    fg_color = "rgb(000000)",
    size = 14,
    icon = "",
    action = "hyprctl dispatch 'hl.dsp.window.move({ workspace = \"special:magic\", follow = false })'",
  },
  {
    bg_color = "rgb(28c840)",
    fg_color = "rgb(000000)",
    size = 14,
    icon = "",
    action = "hyprctl dispatch 'hl.dsp.window.fullscreen({ action = \"toggle\", mode = \"maximized\" })'",
  },
}

-- for _, button in ipairs(buttons) do
--   hl.plugin.hyprbars.add_button(button)
-- end

return {
  enabled = true,
  bar_height = 30,
  bar_blur = true,
  bar_padding = 8,
  bar_button_padding = 9,
  bar_buttons_alignment = "left",

  bar_color = "rgb(1e1e1e)",
  inactive_button_color = "rgb(666666)",

  col = {
    text = "rgb(9a9a9a)",
  },

  bar_text_align = "left",
  bar_text_size = 13,
  bar_text_weight = 700,
  bar_text_font = "SF Pro Text",
  bar_precedence_over_border = true,
  icon_on_hover = false,
  on_double_click = "hyprctl dispatch 'hl.dsp.window.fullscreen({ action = \"toggle\", mode = \"maximized\" })'",
}
