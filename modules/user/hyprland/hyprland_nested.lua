local terminal = "kitty"
local file_manager = "nautilus"
local menu = "vicinae 'vicinae://toggle'"
local main_mod = "ALT"

Config = {
  terminal = terminal,
  file_manager = file_manager,
  menu = menu,
  main_mod = main_mod,
}

require("modules.windowrules")
require("modules.quickshell")
require("modules.animations")
require("modules.autostart")
require("modules.monitors")
require("modules.keybinds")
require("modules.general")
require("modules.glass")
require("modules.plugins")
require("modules.input")
require("modules.env")
