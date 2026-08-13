return {
	{
		'mikavilpas/yazi.nvim',
		event = 'VeryLazy',
		dependencies = {
			{ 'nvim-lua/plenary.nvim', lazy = true },
		},
		opts = {
			open_for_directories = true,
		},
		init = function()
			vim.g.loaded_netrwPlugin = 1
		end,
		keys = {
			{
				"<leader>-",
				"<cmd>Yazi<cr>",
				desc = "Open Yazi at the current file",
			},
			{
				"<leader>fm",
				"<cmd>Yazi cwd<cr>",
				desc = "Open Yazi in nvim's current directory",
			},
		},
	},
}
