hl.bind("SUPER + X", function()
	local w = hl.get_active_window()
	if w ~= nil and w.title == "htop" do
		hl.dispatch(hl.dsp.window.float({ action = "set" }))
	else
		hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	end
end)
