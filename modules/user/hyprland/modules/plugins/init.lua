hl.permission({
  binary = "/usr/(bin|local/bin)/hyprpm",
  type = "plugin",
  mode = "allow",
})

local plugin_cfg = {}
local plugin_setup = {}

for _, spec in ipairs({
  { key = "borders_plus_plus", module = "modules.plugins.borders_plus_plus" },
  { key = "dynamic_cursors", module = "modules.plugins.dynamic_cursors" },
  -- { key = "darkwindow", module = "modules.plugins.darkwindow" },
  { key = "hyprglass", module = "modules.plugins.hyprglass" },
  { key = "hyprbars", module = "modules.plugins.hyprbars" },
}) do
  local mod = require(spec.module)
  if mod then
    if mod.config ~= nil then
      plugin_cfg[spec.key] = mod.config
    elseif mod.setup == nil then
      plugin_cfg[spec.key] = mod
    end

    if mod.setup ~= nil then
      table.insert(plugin_setup, mod.setup)
    end
  end
end

if next(plugin_cfg) ~= nil then
  hl.config({
    plugin = plugin_cfg,
  })
end

for _, setup in ipairs(plugin_setup) do
  setup()
end

hl.bind("SUPER + ALT + T", function()
  if hl.plugin.hyprbars ~= nil then
    hl.exec_cmd("hyprpm disable hyprbars")
  else
    hl.exec_cmd("hyprpm enable hyprbars")
    hl.exec_cmd("hyprpm reload")
  end
end)
