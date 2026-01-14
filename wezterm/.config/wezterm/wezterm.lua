local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Always start zsh in WezTerm
config.default_prog = { "/usr/bin/zsh" } -- adjust if `which zsh` differs

-- Font + fallbacks (no patched font required)
config.font = wezterm.font_with_fallback({
	"JetBrains Mono", -- bundled with WezTerm
	"Symbols Nerd Font", -- icons/powerline
	"Noto Color Emoji",
})
config.font_size = 12.5

-- Theme
config.color_scheme = "Catppuccin Mocha"

-- Window & tabs
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }

-- Right status: cwd | battery | time
wezterm.on("update-right-status", function(window, pane)
	local cwd = ""
	local uri = pane:get_current_working_dir()
	if uri then
		cwd = uri:gsub("^file://", ""):gsub("^[^/]*", "")
	end
	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		bat = string.format(" %d%%", math.floor(b.state_of_charge * 100))
		break
	end
	local clock = wezterm.strftime(" %a %b %-d %H:%M")
	window:set_right_status(wezterm.format({
		{ Foreground = { AnsiColor = "Fuchsia" } },
		cwd,
		{ Text = "  " },
		{ Foreground = { AnsiColor = "Yellow" } },
		bat,
		{ Text = "  " },
		{ Foreground = { AnsiColor = "Aqua" } },
		clock,
	}))
end)

return config
