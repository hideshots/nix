hl.config({
  animations = {
    enabled = true,
  },
})

local beziers = {
  { "default", { { 0.25, 0.1 }, { 0.25, 1.0 } } },
  { "linear", { { 0.0, 0.0 }, { 1.0, 1.0 } } },
  { "ease", { { 0.25, 0.1 }, { 0.25, 1.0 } } },
  { "ease-in", { { 0.42, 0.0 }, { 1.0, 1.0 } } },
  { "ease-out", { { 0.0, 0.0 }, { 0.58, 1.0 } } },
  { "ease-in-out", { { 0.76, 0.0 }, { 0.24, 1.0 } } },
  { "ease-out-back", { { 0.25, 1.0 }, { 0.5, 1.0 } } },
  { "easeInOutQuart", { { 0.77, 0.0 }, { 0.175, 1.0 } } },
  { "easeOutBack", { { 0.34, 1.56 }, { 0.64, 1.0 } } },
  { "easeInOutCubic", { { 0.65, 0.0 }, { 0.35, 1.0 } } },
  { "macosGenie", { { 0.25, 0.46 }, { 0.45, 0.94 } } },
  { "macosScale", { { 0.16, 1.0 }, { 0.3, 1.0 } } },
  { "macosSlide", { { 0.23, 1.0 }, { 0.32, 1.0 } } },
  { "out", { { 0.0, 1.0 }, { 0.6, 1.0 } } },
}

for _, curve in ipairs(beziers) do
  hl.curve(curve[1], { type = "bezier", points = curve[2] })
end

local animations = {
  { leaf = "zoomFactor", enabled = true, speed = 1, bezier = "ease-out" },
  { leaf = "windows", enabled = true, speed = 3, bezier = "ease", style = "popin 98%" },
  { leaf = "windowsOut", enabled = true, speed = 5, bezier = "ease", style = "popin 95%" },
  { leaf = "windowsMove", enabled = true, speed = 3.5, bezier = "out", style = "gnomed" },
  { leaf = "layers", enabled = true, speed = 8, bezier = "easeInOutCubic", style = "fade" },
  { leaf = "fadeLayers", enabled = true, speed = 6, bezier = "easeInOutCubic" },
  { leaf = "fadeLayersIn", enabled = true, speed = 3, bezier = "easeOutBack" },
  { leaf = "fadeLayersOut", enabled = true, speed = 3, bezier = "easeInOutCubic" },
  { leaf = "layersIn", enabled = true, speed = 0.4, bezier = "linear"},
  { leaf = "layersOut", enabled = true, speed = 0.4, bezier = "linear"},
  { leaf = "fade", enabled = false },
  { leaf = "fadeIn", enabled = true, speed = 2.5, bezier = "ease" },
  { leaf = "fadeOut", enabled = true, speed = 2, bezier = "ease" },
  { leaf = "border", enabled = true, speed = 1.5, bezier = "linear" },
  { leaf = "workspaces", enabled = true, speed = 6.0, bezier = "macosSlide", style = "slide" },
  { leaf = "specialWorkspaceIn", enabled = true, speed = 2, bezier = "ease", style = "fade" },
  { leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "ease", style = "fade" },
}

for _, animation in ipairs(animations) do
  hl.animation(animation)
end
