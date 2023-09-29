return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
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
				enabled = true,
				char = "⁞",
				tab_char = "⁞",
				smart_indent_cap = false,
			},
			whitespace = {
				enabled = true,
				remove_blankline_trail = true
			},
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
				injected_languages = false,
				include = {
					node_type = {
						["*"] = { "*" },
					},
				},
				exclude = {
					filetypes = {
						"lspinfo",
						"packer",
						"help",
						"man",
						"gitcommit",
						"TelescopePrompt",
					},
					buftypes = {
						"terminal",
						"nofile",
						"quickfix",
						"prompt",
					},
				},
			},
		})
	end,
}
