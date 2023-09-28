return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			enabled = true,
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
				enabled = true,
				include = {
					node_type = { "*" },
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
