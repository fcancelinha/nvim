return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			themable = true,
			indicator = {
				icon = '▎', -- this should be omitted if indicator style is not 'icon'
				style = 'icon', -- | 'underline' | 'none',
			},
			diagnostics = "nvim_lsp",
			color_icons = true,
			show_buffer_icons = true,
			always_show_bufferline = true,
			tab_size = 20,
			hover = {
				enabled = true,
				delay = 200,
				reveal = { 'close' }
			},
			sort_by = 'insert_after_current',
		},
		highlights = {
			fill = {
				fg = '#2E3340',
				bg = '#2E3340',
			},
			indicator_selected = {
				fg = '#88C0D0',
				-- bg = '#88C0D0',
			},
		}
	}
}
