local startup = {
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
  "gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"",
  "wl-paste --type image --watch cliphist store",
  "wl-paste --type text --watch cliphist store",
  "easyeffects --gapplication-service",
  "sleep 2 && hyprpm reload -n",
  "/usr/bin/xembedsniproxy &",
  "swww-daemon --format xrgb",
  "waypaper daemon",
  "otd-daemon",
  "vicinae server &",
  "nm-applet &",
  "hyprsunset",
  "windscribe-cli connect &",
  "spotify --enable-gpu-rasterization --enable-zero-copy --enable-gpu-compositing --enable-native-gpu-memory-buffers --enable-oop-rasterization --enable-features=UseSkiaRenderer --ozone-platform=wayland --disable-gpu-sandbox --enable-blink-features=MiddleClickAutoscroll",
  "Telegram -startintray &",
  -- "waypaper --restore",
  "quickshell",
  "hypridle",
  "wal -R",
  "steam",
}

hl.on("hyprland.start", function()
  for _, cmd in ipairs(startup) do
    hl.exec_cmd(cmd)
  end
end)
