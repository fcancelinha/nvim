return {
	'numToStr/FTerm.nvim',
	init = function()
		require 'FTerm'.setup({
			border     = 'single',
			dimensions = {
				height = 0.6,
				width = 0.7,
			},
		})
	end
}
