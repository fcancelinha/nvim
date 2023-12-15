return {
	'akinsho/toggleterm.nvim',
	version = "*",
	opts = {
		open_mapping = [[<leader>ç]],
		persist_mode = true,
		autoscroll = true,
		direction = 'float',
		float_opts = {
			border = 'single',
			width = 200,
			height = 30,
			winblend = 5,
		},
		highlights = {
			-- highlights which map to a highlight group name and a table of it's values
			-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
			Normal = {
				guibg = "#2E3440",
			},
			NormalFloat = {
				link = 'Normal'
			},
			FloatBorder = {
				guifg = "#88C0D0",
				guibg = "#2E3440",
			},
		},
	}
}
