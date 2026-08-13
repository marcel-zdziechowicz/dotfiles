return {
	'RRethy/base16-nvim',
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require('base16-colorscheme').setup({
			base00 = "#171217",
			base01 = "#110d11",
			base02 = "#1f1a1f",
			base03 = "#4d444c",
			base04 = "#cfc3cd",
			base05 = "#eae0e7",
			base06 = "#342f34",
			base07 = "#3d373d",
			base08 = "#f2a299",
			base09 = "#f5b7b0",
			base0A = "#d6c0d6",
			base0B = "#e9b5ef",
			base0C = "#673b36",
			base0D = "#603768",
			base0E = "#524153",
			base0F = "#c2a1c2",
		})

		vim.api.nvim_set_hl(0, 'Visual', {
			bg = '#603768',
			fg = '#171217',
		})
	end
}
