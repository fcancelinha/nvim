return {
	"romgrk/barbar.nvim",
	dependencies = {
		'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
		'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
	},
	init = function()
		vim.cmd('hi BufferTabpageFill guibg=#000000')
	end,
	opts = {
		animation = true,
		maximum_padding = 2,
		no_name_title = nil,
	},
}


