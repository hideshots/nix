local env = {
  EWW_PRIMARY_MONITOR = "1",
  MOZ_ENABLE_WAYLAND = "1",
  XDG_SESSION_TYPE = "wayland",
  QT_QPA_PLATFORM = "wayland",
  LIBVA_DRIVER_NAME = "nvidia",
  __GLX_VENDOR_LIBRARY_NAME = "nvidia",
  ELECTRON_OZONE_PLATFORM_HINT = "auto",
  GBM_BACKEND = "nvidia-drm",
  NVD_BACKEND = "direct",
  QT_QPA_PLATFORMTHEME = "qt6ct",
  XCURSOR_THEME = "macOS",
  HYPRCURSOR_THEME = "macOS-hypr",
  XCURSOR_SIZE = "24",
  HYPRCURSOR_SIZE = "24",
}

for key, value in pairs(env) do
  hl.env(key, value)
end

hl.config({
  xwayland = {
    enabled = true,
  },
})
