return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-t>]],
			direction = 'float',
			float_opts = {
				border = 'single',
				title_pos = 'left',
				width = 135,
				height = 30,
			},
			highlights = {
				NormalFloat = {
					link = '#2E3440'
				},
				FloatBorder = {
					guibg = "#2E3440",
					guifg = "#88C0D0",
				},
			},
		})
	end
}
