-- require('variables')

hl.on("hyprland.start", function ()
	hl.exec_cmd("dunst")
	hl.exec_cmd("waybar")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-- exec-once = [workspace 1] $terminal
-- exec-once = [workspace 2] $browser
-- exec-once = [workspace 10] spotify
