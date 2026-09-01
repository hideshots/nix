local main_mod = Config.main_mod
local terminal = Config.terminal
local file_manager = Config.file_manager
local menu = Config.menu

local lib = require("lib")

local bind = lib.bind
local bind_all = lib.bind_all
local exec = lib.exec

local function mouse_bind(keys, dispatcher)
  bind(keys, dispatcher, { mouse = true })
end

local function workspace_bind(key, workspace)
  bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
  bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

local function screenshot_cmd(mode, copy_cmd)
  return string.format(
    [[mkdir -p "$HOME/Pictures/Screenshots"; file="$HOME/Pictures/Screenshots/Screenshot-$(date "+%%Y%%m%%d-%%H%%M%%S").png"; hyprshot -z -m %s --raw | %s | wl-copy --type image/png]],
    mode,
    copy_cmd
  )
end

local function zoom_cmd(multiplier)
  return string.format(
    [[value="$(hyprctl getoption cursor.zoom_factor -j | jq '(.float * %s) | if . < 1 then 1 else . end')"; hyprctl eval "hl.config({ cursor = { zoom_factor = $value }})"]],
    multiplier
  )
end

-- Utilities
bind_all({
  { "CONTROL + SHIFT + Escape", exec("kitty --class kitty-monitoring --session /home/drama/.config/kitty/sessions/monitoring.session"), },
  { "CONTROL + 0", exec("obs-cmd replay save") },
  { "CONTROL + SHIFT + 0", exec("obs-cmd replay toggle") },
  { "CONTROL + SHIFT + TAB", exec("missioncenter") },
  -- { "HOME", exec("hyprfreeze -a") },
  { main_mod .. " + SHIFT + C", exec("hyprpicker -a") },
  { main_mod .. " + slash", exec("/home/drama/.local/bin/madlion-gamepad toggle-gamepad") },
  { main_mod .. " + SHIFT + M", hl.dsp.workspace.toggle_special("rmpc") },
})

-- hl.bind("CONTROL + W", function()
--   local win = hl.get_active_window()
--   if win and win.class and string.match(string.lower(win.class), "^zen") then
--     hl.dispatch(hl.dsp.send_shortcut({ mods = "CONTROL", key = "BackSpace" }))
--   else
--     hl.dispatch(hl.dsp.send_shortcut({ mods = "CONTROL", key = "W" }))
--   end
-- end, { auto_consuming = true })

bind(main_mod .. " + ALT + S", function()
  hl.timer(function()
    hl.dispatch(hl.dsp.dpms({ action = "toggle" }))
  end, { timeout = 1000, type = "oneshot" })
end)

-- Screenshots & OSR
bind_all({
  { main_mod .. " + SHIFT + T", exec("~/dotfiles/modules/user/scripts/osr.sh") },
  { "Print", exec(screenshot_cmd("region", "tee \"$file\"")) },
  { "SHIFT + Print", exec(screenshot_cmd("output", "tee \"$file\"")) },
  {
    "CTRL + Print",
    exec(
      [[mkdir -p "$HOME/Pictures/Screenshots"; file="$HOME/Pictures/Screenshots/Screenshot-$(date "+%Y%m%d-%H%M%S").png"; hyprshot -z -m output --raw | satty --filename - --fullscreen --output-filename "$file" --copy-command wl-copy --actions-on-enter save-to-clipboard]]
    ),
  },
})

-- Scripts
bind_all({
  { main_mod .. " + W", exec("bash ~/dotfiles/modules/user/scripts/toggle-mic.sh") },
})

-- Apps
bind_all({
  { main_mod .. " + E", exec("kitty --class " .. terminal .. "-yazi yazi") },
  { main_mod .. " + ALT + O", exec("kitty --class " .. terminal .. "-obsidian sh -c 'cd /mnt/hdd/Notes/Personal && nvim +\"autocmd BufEnter *.md ++once normal! G\" +ObsidianToday' & sleep 0.5; hyprctl dispatch setfloating") },
  { main_mod .. " + Q", exec(terminal) },
  { main_mod .. " + ALT + Q", exec("kitty -o shell=zsh") },
  { main_mod .. " + R", exec(menu) },
  { main_mod .. " + SHIFT + E", exec(file_manager) },
  { main_mod .. " + SHIFT + Q", hl.dsp.window.close() },
  { main_mod .. " + SHIFT + R", exec("foot") },
  { main_mod .. " + V", exec("vicinae 'vicinae://launch/clipboard/history?toggle=true'") },
  { main_mod .. " + semicolon", exec("vicinae 'vicinae://launch/core/search-emojis?toggle=true'") },
})


hl.bind(main_mod .. " + ALT + G", hl.dsp.group.toggle())

hl.bind(main_mod .. " + ALT + L", hl.dsp.group.next())
hl.bind(main_mod .. " + ALT + H", hl.dsp.group.prev())
-- Layout controls
bind_all({
  { main_mod .. " + C", hl.dsp.window.float({ action = "toggle" }) },
  { main_mod .. " + ALT + C", function()
    hl.timer(function()
      hl.dispatch(hl.dsp.window.resize({ x = 1000, y = 640 }))
      hl.dispatch(hl.dsp.window.center())
    end, { timeout = 1, type = "oneshot" })
  end },
  { main_mod .. " + ALT + P", hl.dsp.window.pin() },
  { main_mod .. " + ALT + a", hl.dsp.layout("fit all") },
  { main_mod .. " + ALT + b", hl.dsp.layout("fit tobeg") },
  { main_mod .. " + ALT + e", hl.dsp.layout("fit toend") },
  { main_mod .. " + ALT + f", hl.dsp.layout("fit active") },
  { main_mod .. " + ALT + v", hl.dsp.layout("fit visible") },
  { main_mod .. " + T", hl.dsp.layout("promote") },
  { main_mod .. " + D", hl.dsp.window.cycle_next({ floating = true }) },
  { main_mod .. " + F", hl.dsp.window.fullscreen() },
})

-- Focus movement
bind_all({
  { main_mod .. " + Tab", hl.dsp.focus({ workspace = "previous" }) },
  { main_mod .. " + h", hl.dsp.focus({ direction = "l" }) },
  { main_mod .. " + j", hl.dsp.focus({ direction = "d" }) },
  { main_mod .. " + k", hl.dsp.focus({ direction = "u" }) },
  { main_mod .. " + l", hl.dsp.focus({ direction = "r" }) },
})

-- Move / swap / resize
bind_all({
  { main_mod .. " + SHIFT + H", hl.dsp.window.move({ x = -60, y = 0, relative = true }) },
  { main_mod .. " + SHIFT + J", hl.dsp.window.move({ x = 0, y = 60, relative = true }) },
  { main_mod .. " + SHIFT + K", hl.dsp.window.move({ x = 0, y = -60, relative = true }) },
  { main_mod .. " + SHIFT + L", hl.dsp.window.move({ x = 60, y = 0, relative = true }) },
  { main_mod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "l" }) },
  { main_mod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "d" }) },
  { main_mod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "u" }) },
  { main_mod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "r" }) },
  { main_mod .. " + equal", hl.dsp.layout("colresize +conf") },
  { main_mod .. " + minus", hl.dsp.layout("colresize -conf") },
  { main_mod .. " + i", hl.dsp.window.resize({ x = 0, y = 50, relative = true }) },
  { main_mod .. " + o", hl.dsp.window.resize({ x = 0, y = -50, relative = true }) },
  { main_mod .. " + p", hl.dsp.window.resize({ x = 50, y = 0, relative = true }) },
  { main_mod .. " + u", hl.dsp.window.resize({ x = -50, y = 0, relative = true }) },
})

-- Workspaces
for i = 1, 10 do
  local key = tostring(i % 10)
  workspace_bind(key, i)
end

 bind(main_mod .. " + SHIFT + ALT + W", function()
  hl.timer(function()
    hl.dispatch(hl.dsp.window.resize({ x = 1916, y = 1040 }))
  end, { timeout = 1, type = "oneshot" })
end)

bind(main_mod .. " + SHIFT + ALT + M", function()
  hl.dispatch(hl.dsp.window.float({ action = "set" }))
  hl.timer(function()
    hl.dispatch(hl.dsp.window.resize({ x = 5760, y = 1080 }))
    hl.dispatch(hl.dsp.window.move({ x = 0, y = 0 }))
  end, { timeout = 1, type = "oneshot" })
end)

bind_all({
  { main_mod .. " + bracketleft", hl.dsp.focus({ workspace = 11 }) },
  { main_mod .. " + bracketright", hl.dsp.focus({ workspace = 12 }) },
  { main_mod .. " + SHIFT + bracketleft", hl.dsp.window.move({ workspace = 11 }) },
  { main_mod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = 12 }) },
  { main_mod .. " + S", hl.dsp.workspace.toggle_special("magic") },
  { main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }) },
  { main_mod .. " + Escape", hl.dsp.workspace.toggle_special("escape") },
  { main_mod .. " + SHIFT + Escape", hl.dsp.window.move({ workspace = "special:escape" }) },
})

-- Mouse bindings
hl.bind("SUPER + mouse:276", function()
    local win = hl.get_active_window()
    local mon = win and win.monitor
    if not win or not mon then
        return
    end

    hl.dispatch(hl.dsp.window.move({
        x = mon.x + (mon.width - win.size.x) / 2,
        y = win.at.y,
        window = win
    }))
end)

hl.bind("SUPER + mouse:275", function()
    local win = hl.get_active_window()
    local mon = win and win.monitor
    if not win or not mon then
        return
    end

    hl.dispatch(hl.dsp.window.move({
        x = win.at.x,
        y = mon.y + (mon.height - win.size.y) / 2,
        window = win
    }))
end)

bind_all({
  { main_mod .. " + mouse_down", hl.dsp.layout("move +col") },
  { main_mod .. " + mouse_up", hl.dsp.layout("move -col") },
  { main_mod .. " + SHIFT + mouse_down", exec(zoom_cmd("1.5")) },
  { main_mod .. " + SHIFT + mouse_up", exec(zoom_cmd("0.5")) },
{ main_mod .. " + mouse:274", exec("hyprfreeze -a"), },
})

mouse_bind(main_mod .. " + mouse:272", hl.dsp.window.drag())
mouse_bind(main_mod .. " + mouse:273", hl.dsp.window.resize())

hl.config({
  binds = {
    scroll_event_delay = 0,
  },
})

-- Media keys
bind("XF86AudioRaiseVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
bind("XF86MonBrightnessUp", exec("brightnessctl s 10%+"), { locked = true, repeating = true })
bind("XF86MonBrightnessDown", exec("brightnessctl s 10%-"), { locked = true, repeating = true })
bind("XF86AudioNext", exec("playerctl next"), { locked = true })
bind("XF86AudioPrev", exec("playerctl previous"), { locked = true })
bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true })

-- wl-kbptr
local function kbptr_cmd(args)
  return string.format([[hyprctl dispatch "hl.dsp.submap('reset')"; wl-kbptr %s; hyprctl dispatch "hl.dsp.submap('cursor')"]], args)
end

-- Enter cursor submap and wake up analog polling:
bind(main_mod .. " + Control_L", function()
  hl.exec_cmd("/home/drama/.local/bin/madlion-mouse enable")
  hl.dispatch(hl.dsp.submap("cursor"))
end)

-- Cursor submap:
hl.define_submap("cursor", function()
  -- Wl-kbptr floating jump utilities
  bind("a", exec(kbptr_cmd("-o modes=floating,click -o mode_floating.source=detect")))
  bind("Space", exec(kbptr_cmd("-o modes=floating -o mode_floating.source=detect")))

  -- Swallow analog keys so they don't type characters into active windows
  local swallow_keys = { "u", "j", "i" ,"y", "h", "k", "e", "r", "o", "l", "w", "t", "f", "s", "d", "v", "b" }
  for _, k in ipairs(swallow_keys) do
    bind(k, function() end)
    bind("SHIFT + " .. k, function() end)
    bind("CTRL + " .. k, function() end)
  end

  -- Exit submap: put daemon in standby and release all buttons
  local function exit_cursor()
    hl.exec_cmd("/home/drama/.local/bin/madlion-mouse disable")
    hl.dispatch(hl.dsp.submap("reset"))
  end

  bind("Escape", exit_cursor)
  bind("Control_L", exit_cursor)
end)
