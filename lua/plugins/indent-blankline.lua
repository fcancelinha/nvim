return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			enabled = true,
			debounce = 100,
			viewport_buffer = {
				min = 50,
				max = 200,
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
						["*"] = {
							"argument",
							"arguments",
							"block",
							"bracket",
							"declaration",
							"expression_list",
							"field",
							"for",
							"func_literal",
							"function",
							"if",
							"import",
							"import_spec_list",
							"list",
							"return_statement",
							"short_var_declaration",
							"statement",
							"switch_body",
							"try",
							"type",
						},
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
