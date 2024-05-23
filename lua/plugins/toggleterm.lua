return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]], -- or { [[<c-\>]], [[<c->]] } if you also use a Japanese keyboard.
			direction = 'float',
			float_opts = {
				border = 'single',
				title_pos = 'right',
			},
		})
	end
}
