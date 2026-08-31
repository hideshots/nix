local terminal = "kitty"
local file_manager = "dolphin"
local menu = "vicinae 'vicinae://toggle'"
local main_mod = "SUPER"

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
require("modules.plugins")
require("modules.input")
-- require("modules.glass")
require("modules.env")
