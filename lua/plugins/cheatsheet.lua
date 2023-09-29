return {
	"Djancyp/cheat-sheet",
	lazy = true,
	config = function()
		require("cheat-sheet").setup({
			auto_fill = {
				filetype = true,
				current_word = true,
			},
			main_win = {
				style = "minimal",
				border = "single",
			},
			input_win = {
				style = "minimal",
				border = "single",
			},
		})
	end
}
