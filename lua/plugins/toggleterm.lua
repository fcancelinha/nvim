return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		require("toggleterm").setup({
			autochdir = true,
			open_mapping = [[<c-\>]],
			shade_terminals = false,
			hide_numbers = true,
			start_in_insert = true,
			direction = 'horizontal',
			persist_size = true,
			persist_mode = true,
			close_on_exit = false,
			float_opts = {
				border = 'curved',
				winblend = 10,
				title_pos = 'center',
			},
		})
	end
}
