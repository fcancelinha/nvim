return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			enabled = true,
			debounce = 100,
			viewport_buffer = {
				min = 50,
				max = 250,
			},
			indent = {
				char = "│",
				tab_char = "│",
				smart_indent_cap = true,
			},
			whitespace = {
				remove_blankline_trail = true
			},
			scope = {
				show_start = false,
				show_end = false,
				injected_languages = true,
				include = {
					node_type = {
						["*"] = { "*" },
					},
				},
				exclude = {
					language = { "bash" },
				},
			},
		})
	end,
}
