return {
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		keys = {
			{
				"<leader>?",
				function()
					require('which-key').show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		config = function()
			require('which-key').setup()
			require('which-key').add {
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk" },
			}
		end,
	}
}
