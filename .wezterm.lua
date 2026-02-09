local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.font_dirs = { "../../Windows/Fonts/" }
config.font = wezterm.font("JuliaMono Nerd Font Mono", { weight = "Medium", style = "Italic" })
config.automatically_reload_config = true
config.color_scheme = "Gruvbox Material (Gogh)"
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 3,
	right = 3,
	top = 1,
	bottom = 1,
}

return config
