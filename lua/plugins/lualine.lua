return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = 'nord',
				component_separators = {left = "", right = ""},
				section_separators = {left="", right = ""},
				disabled_filetypes = {"alpha", "dashboard", "neo-tree"},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						padding = 2,
					}
				},
				lualine_b = {},
				lualine_c = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic", "nvim_lsp" },
						sections = { "error", "warn" },
						symbols = { error = "  ", warn = "  "},
						colored = true,
						update_in_insert = true,
						always_visible = true,
						diagnostics_color = {
							error = 'DiagnosticError',
							warn = 'DiagnosticWarn',
						},
					},
				},
				lualine_x = {
					{
						"branch",
						padding = 1,
					},
					{
						"diff",
						colored = true,
						symbols = { added = "  ", modified = "  ", removed = "  " }, -- changes diff symbols
					},
					{
						"fileformat",
						colored = true
					},
					{
						"require'lsp-status'.status()",
						colored = true,
					},
				},
				lualine_y = {
					{
						"encoding",
						colored = true
					},
					{
						"filetype",
						colored = true,
						icons_only = true,
					},
					{
						"searchcount",
						maxcount = 999,
						timeout =  500
					},
				},
				lualine_z = {
					{
						"location",
						padding = 2
					},
				},
			},
		},
	}
}
