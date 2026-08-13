-- require('variables')

-- eww lives in ~/.local/bin (built by install.sh), which is
-- not on Hyprland's PATH, so it needs a full path here.
local eww = os.getenv("HOME") .. "/.local/bin/eww"

hl.on("hyprland.start", function ()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("dunst")
	hl.exec_cmd(eww .. " daemon")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-- exec-once = [workspace 1] $terminal
-- exec-once = [workspace 2] $browser
-- exec-once = [workspace 10] spotify
