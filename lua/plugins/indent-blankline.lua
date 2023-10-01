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
				char = "⁞",
				tab_char = "⁞",
				smart_indent_cap = false,
			},
			whitespace = {
				remove_blankline_trail = true
			},
			scope = {
				show_start = false,
				show_end = false,
				injected_languages = false,
				include = {
					node_type = {
						["*"] = { "*" },
					},
				},
				exclude = {
					{ "bash" },
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
						"bufferline",
					},
				},
			},
		})
	end,
}
