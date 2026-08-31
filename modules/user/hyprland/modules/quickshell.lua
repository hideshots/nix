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
hl.bind(main_mod .. " + SHIFT + B", sh("qs ipc call shell toggleMenuBarBlur; qs ipc --any-display call shell toggleWidgetsVisibility; qs ipc --any-display call shell toggleBarVisibility"))

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

hl.layer_rule({
  name = "quickshell-menu",
  match = {
    namespace = "quickshell:menu",
  },
  no_anim = true,
})

hl.window_rule({ name = "quickshell-settings", match = { class = "^org\\.quickshell$", title = "^Settings$" }, float = true, rounding = 20, rounding_power = 3 })
