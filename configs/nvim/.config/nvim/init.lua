require("general")
require("plugins")

local function load_configs()
  require("misc")
  require("lsp")
  require("keybindings")
  require("statusline")
  require("filetree")
end

pcall(load_configs)
