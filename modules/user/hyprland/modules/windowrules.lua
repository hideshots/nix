local terminal = Config.terminal

hl.workspace_rule({
    workspace = "w[tv1]s[false]",
    gaps_in = 0,
    gaps_out = {
        top = 0,
        right = 0,
        bottom = 0,
        left = 0,
    },
})

-- hl.window_rule({
--   name = "no-gaps-wtv1",
--   match = {
--     float = false,
--     workspace = "w[tv1]s[false]",
--   },
--   -- border_size = 0,
--   rounding = 10,
-- })

hl.window_rule({
  name = "pinned",
  match = {
    pin = true,
  },
  rounding = 5,
  no_shadow = 1,
  border_size = 0,
})

hl.window_rule({
    name = "flstudio-helper",
    match = {
        class = "fl64.exe",
        title = "^$",
    },
    float = true,
    workspace = "special:flhelper silent",
})

hl.window_rule({
    name = "flstudio-main",
    match = {
        class = "^fl64%.exe$",
        title = "^FL Studio 2026$",
    },
    suppress_event = "fullscreen maximize",
})

hl.window_rule({
  name = "afterfx-main",
  match = {
    class = "^(afterfx\\.exe)$",
    xwayland = true,
  },
  no_anim = true,
})

hl.window_rule({
  name = "afterfx-popup",
  match = {
    class = "^(afterfx\\.exe)$",
    xwayland = true,
    title = "^$",
  },
  float = true,
  opacity = "1.0",
  rounding = 0,
  no_blur = true,
  no_anim = true,
  -- no_focus = true,
  -- no_initial_focus = true,
  suppress_event = "activatefocus",
})

-- hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 2, gaps_in = 0 })
-- hl.window_rule({
--   name = "no-gaps-f1",
--   match = {
--     float = false,
--     workspace = "f[1]s[false]",
--   },
--   border_size = 0,
--   rounding = 12,
-- })
--
hl.layer_rule({
  name = "nwg-dock-blur",
  match = {
    namespace = "nwg-dock",
  },
  blur = true,
  ignore_alpha = 0,
})

hl.config({
  scrolling = {
    column_width = 0.50,
    focus_fit_method = 1,
    follow_focus = true,
    follow_min_visible = 0.7,
    fullscreen_on_one_column = true,
    direction = "right",
  },
})

hl.window_rule({
  name = "mayhem-noblur",
  match = { class = "^(mayhem-loader|mayhem-menu|mayhem)$" },
  tag = "+hyprglass_disabled",
})

hl.window_rule({
  name = "mayhem-loader",
  match = { class = "^(mayhem-loader)$" },
  float = true,
  border_size = 0,
  rounding = 5,
  -- no_screen_share = true,
  -- min_size = { 520, 400 },
  -- max_size = { 520, 400 },
})

hl.window_rule({
  name = "mayhem-menu",
  match = { class = "^(mayhem-menu)$" },
  workspace = "special:magic silent",
  float = true,
  border_size = 0,
  rounding = 2,
  no_anim = true,
  min_size = { 485, 320 },
  max_size = { 620, 700 },
})

hl.window_rule({
  name = "mayhem-overlay",
  match = { class = "^(mayhem)$" },
  float = true,
  pin = true,
  size = { "monitor_w", "monitor_h" },
  move = { 0, 0 },
  no_initial_focus = true,
  no_focus = true,
  no_anim = true,
  no_blur = true,
  no_shadow = true,
  border_size = 0,
  rounding = 0,
})

hl.window_rule({
  name = "special",
  match = {
    class = "^(helium)$",
  },
  workspace = "special:magic silent",
  float = true,
  center = true,
})

hl.window_rule({
  name = "ida-tile",
  match = {
    class = "^com\\.hex-rays\\.ida$",
    initial_title = "^IDA - .*$",
  },
  tile = true,
})

hl.window_rule({
  name = "ida-wait",
  match = {
    class = "^com\\.hex-rays\\.ida$",
    initial_title = "^Please wait\\.\\.\\.$",
  },
  float = true,
  center = true,
  no_initial_focus = true,
})

hl.window_rule({
  name = "ws-zen",
  match = {
    class = "^(zen)$",
  },
  workspace = "3",
})

hl.window_rule({
  name = "ws-steam",
  match = {
    class = "^(steam)$",
  },
  no_initial_focus = true,
  workspace = "4",
})

hl.window_rule({
  name = "ws-spotify",
  match = {
    class = "^(Spotify)$",
  },
  no_initial_focus = true,
  workspace = "5",
  ["darkwindow:shade"] = hl.plugin.darkwindow ~= nil and "blackKey" or nil,
})

hl.window_rule({
  name = "ws-discord",
  match = {
    class = "^(discord)$",
  },
  no_initial_focus = true,
  workspace = "11",
})

hl.window_rule({
  name = "kitty-monitoring",
  match = {
    class = "kitty-monitoring",
  },
  float = true,
  size = { "70%", "90%" },
  center = true,
})

hl.window_rule({
  name = "spotify-pop-out",
  match = {
    class = "^(chromium-browser)$",
  },
  no_blur = true,
  border_size = 0,
  no_anim = true,
  no_shadow = true,
  rounding = 5,
})

hl.layer_rule({
  name = "vicinae-blur",
  match = { namespace = "vicinae" },
  blur = true,
  ignore_alpha = 0.2,
})

hl.window_rule({
  name = "noblur-steam-proton",
  match = {
    class = "^(steam_proton)$",
  },
  no_blur = true,
  no_anim = true,
  no_shadow = true,
  rounding = 5,
})

hl.window_rule({
  name = "missioncenter",
  match = {
    class = "^(io\\.missioncenter\\.MissionCenter)$",
  },
  float = true,
  center = true,
})

hl.window_rule({
  name = "term-yazi",
  match = {
    class = "^(" .. terminal .. "-yazi)$",
  },
  float = true,
  size = { "monitor_w*0.6", "monitor_h*0.6" },
  center = true,
})

hl.window_rule({
  name = "term-obsidian",
  match = {
    class = "^(" .. terminal .. "-obsidian)$",
  },
  float = true,
  size = { "monitor_w*0.5", "monitor_h*0.9" },
  center = true,
})

hl.window_rule({
  name = "nautilus",
  match = {
    class = "^(org.gnome.Nautilus)$",
  },
  float = true,
  size = { "60%", "60%" },
  center = true,
})

hl.window_rule({
  name = "dolphin",
  match = {
    class = "org.kde.dolphin|org.kde.ark",
  },
  float = true,
  size = { "60%", "60%" },
  center = true,
})

hl.window_rule({
  name = "ark extracting dialog",
  match = {
    class = "org.kde.ark",
    title = "^Extracting.*",
  },
  float = true,
  size = {"700", "169"},
move = { "(monitor_w-700)/2", "40" },
})

hl.window_rule({
  name = "rofi-noblur",
  match = {
    class = "^(Rofi)$",
  },
  no_blur = true,
})

hl.window_rule({
  name = "thorium-noblur",
  match = {
    class = "^(Thorium-browser)$",
  },
  no_blur = true,
})

hl.window_rule({
  name = "zen-pip",
  match = {
    class = "^(zen)$",
    title = "^(Picture-in-Picture)$",
  },
  float = true,
  pin = true,
  keep_aspect_ratio = true,
})

hl.window_rule({
  name = "suppress-maximize",
  match = {
    class = ".*",
  },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "xwaylandvideobridge-hide",
  match = { class = "^(xwaylandvideobridge)$" },
  opacity = "0.0 override",
  no_anim = true,
  no_initial_focus = true,
  max_size = { 1, 1 },
  no_blur = true,
  no_focus = true,
})

hl.window_rule({
  name = "motrix-center",
  match = {
    class = "^(Motrix)$",
  },
  center = true,
})

hl.window_rule({
  name = "windscribe-float",
  match = {
    class = "^(Windscribe)$",
  },
  float = true,
  center = true,
  size = { 350, 350 },
  max_size = { 350, 264 },
  no_blur = true,
  no_shadow = true,
  rounding = 12,
})

hl.window_rule({
  name = "satty-noanim",
  match = {
    class = "^(com\\.gabm\\.satty)$",
  },
  no_anim = true,
})

hl.window_rule({
  name = "preview-fullscreen",
  match = {
    class = "^(org\\.gnome\\.Loupe)$",
  },
  fullscreen = true,
})

hl.window_rule({
  name = "mpv-fullscreen",
  match = {
    class = "^(mpv)$",
  },
  fullscreen = true,
})

hl.window_rule({
  name = "telegram-float",
  match = {
    class = "^(org\\.telegram\\.desktop)$",
  },
  float = true,
  rounding = 11,
})
