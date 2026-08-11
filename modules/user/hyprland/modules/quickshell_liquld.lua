local main_mod = Config.main_mod
local function sh(cmd)
  return hl.dsp.exec_cmd(cmd)
end

hl.bind(main_mod .. " + Z", sh([[notify-send --action="REPLY=Open" --action="dismiss=Mark As " "Alice" "Hey, are you free for a call? Notification description lorem ipsum dolor sit ament."]]))
hl.bind(main_mod .. " + X", sh("pkill quickshell; quickshell"))
hl.bind(main_mod .. " + A", sh("qs ipc call shell toggleControlCenter"))
hl.bind(main_mod .. " + N", sh("qs ipc call shell toggleNotificationCenter"))
hl.bind(main_mod .. " + G", sh("qs ipc call shell toggleAudioMixer"))
hl.bind(main_mod .. " + B", sh("qs ipc --any-display call shell toggleBarVisibility"))
hl.bind(main_mod .. " + SHIFT + B", sh("qs ipc --any-display call shell toggleWidgetsVisibility; qs ipc --any-display call shell toggleBarVisibility"))

local blur_cutoff = {
  none = 0.0,
  soft = 0.1,
  medium = 0.2,
}

local function layer_effect(rule)
  hl.layer_rule({
    name = rule.name,
    match = { namespace = rule.namespace },
    blur = rule.blur ~= false,
    blur_popups = rule.blur_popups == true,
    ignore_alpha = rule.ignore_alpha,
    dim_around = rule.dim_around == true,
    no_anim = rule.no_anim ~= false,
    rounding = rule.rounding or 0,
    rounding_power = rule.rounding_power or 2,
    xray = rule.xray == true,
    no_screen_share = rule.no_screen_share == true,
  })
end

local layer_rules = {
  { name = "no-anim-control-center-empty-slots", namespace = "^quickshell:control-center-empty-slot$", no_anim = true, blur = false },
  { name = "quickshell-control-center-tile-1x1-blur", namespace = "^quickshell:control-center-tile-1x1$", ignore_alpha = blur_cutoff.soft, rounding = 33},
  { name = "quickshell-control-center-tile-2x1-blur", namespace = "^quickshell:control-center-tile-2x1$", ignore_alpha = blur_cutoff.soft, rounding = 33},
  { name = "quickshell-control-center-tile-2x2-blur", namespace = "^quickshell:control-center-tile-2x2$", ignore_alpha = blur_cutoff.soft, rounding = 35 },
  { name = "quickshell-control-center-tile-4x1-blur", namespace = "^quickshell:control-center-tile-4x1$", ignore_alpha = blur_cutoff.soft, rounding = 24},
  { name = "quickshell-control-center-footer-blur", namespace = "^quickshell:control-center-footer$", ignore_alpha = blur_cutoff.soft, rounding = 15 },
  { name = "quickshell-desktop-widgets-blur", namespace = "^quickshell:desktop-widget-(calendar|weather):.*", ignore_alpha = blur_cutoff.none },
  { name = "quickshell-menu-blur", namespace = "^quickshell:menu$", ignore_alpha = blur_cutoff.soft, blur_popups = true },
  { name = "quickshell-notification-popup-backdrop-blur", namespace = "^quickshell:notification-popup-backdrop$", ignore_alpha = blur_cutoff.none, blur_popups = true, no_screen_share = false , rounding = 15},
}

for _, rule in ipairs(layer_rules) do
  layer_effect(rule)
end

layer_effect({
  name = "quickshell-notification-center-blur",
  namespace = "quickshell:(notification-center)$",
  ignore_alpha = blur_cutoff.medium,
  no_anim = false,
})

layer_effect({
  name = "quickshell-widgets-blur",
  namespace = "quickshell:(notification-actions|notification-dismiss)$",
  ignore_alpha = blur_cutoff.soft,
})

hl.window_rule({
  name = "quickshell-alert",
  match = {
    class = "^org\\.quickshell$",
    title = "^Alert$",
  },

  float = true,
  center = true,
  rounding = 20,
  rounding_power = 3,
  no_shadow = true,
  animation = "popin 0%",
})

hl.window_rule({ name = "quickshell-settings", match = { class = "^org\\.quickshell$", title = "^Settings$" }, float = true, rounding = 20, rounding_power = 3 })
