hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
		match = { focus = true },
		idle_inhibit = "fullscreen"
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
		name = "open-blueman-floating",
		match = { class = "blueman-manager" },
		float = true,
		size = { 720, 480 },
})

hl.window_rule({
		name = "open-printer-settings-floating",
		match = { class = "system-config-printer" },
		float = true,
})

hl.window_rule({
		name = "open-qalculate-floating",
		match = { class = "qalculate-gtk" },
		float = true,
		size = { 480, 500 },
})

hl.window_rule({
		name = "open-nwg-look-floating",
		match = { class = "nwg-look" },
		float = true,
})

hl.window_rule({
		name = "open-qt6ct-floating",
		match = { class = "qt6ct" },
		float = true,
		size = { 660, 650 },
})

hl.window_rule({
		name = "open-nm-floating",
		match = { class = "nm-connection-editor" },
		float = true,
})

hl.window_rule({
		name = "open-cmake-floating",
		match = { class = "cmake-gui" },
		float = true,
		size = { 800, 500 },
})

hl.window_rule({
		name = "open-virt-manager-floating",
		match = { class = "virt-manager" },
		float = true,
		size = { 660, 650 },
})

hl.window_rule({
		name = "open-thunar-floating",
		match = { class = "thunar" },
		float = true,
})

hl.window_rule({
	name = "open-eog-floating",
	match = { class = "org.gnome.eog" },
	float = true,
})

hl.window_rule({
		name = "open-file-picker-floating",
		match = { class = "xdg-desktop-portal-gtk" },
		float = true,
		size = { 720, 480 },
})

hl.window_rule({
		name = "open-file-roller-floating",
		match = { class = "org.gnome.FileRoller" },
		float = true,
})

hl.layer_rule({
	blur = true,
	match = { namespace = "gtk-layer-shell" }
})

-- windowrule {
--     name = disable-browser-focus-on-start
--     match:class = brave-browser
--     match:workspace = 2
--     focus_on_activate = off
-- }

-- windowrule {
--     name = run-in-floating-mode
--     match:class = ^(thunar|system-config-printer|nm-connection-editor)$
--     float = on
--     size = 720, 480
-- }

-- windowrule {
--     name = open-file-picker-in-floating-mode
--     match:initial_class = ^(brave)$
--     match:initial_title = ^(Save File)$
--     float = on
--     size = 720, 480
-- }
