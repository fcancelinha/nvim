return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"Isrothy/lualine-diagnostic-message",
	},
	config = function()
		local colors = {
			dark           = '#2E3440',
			frostblue      = '#5E81Ac',
			frostgreen     = '#8FBCBB',
			frostlightblue = '#81A1C1',
			frostturquoise = "#88C0D0",
			green          = '#A3BE8C',
			grey           = "#434C5E",
			greydark       = "#3B4252",
			orange         = '#D08770',
			purple         = '#B48EAD',
			red            = '#BF616A',
			snowdark       = '#D8DEE9',
			snowlight      = '#ECEFF4',
			snowshade      = '#E5E9F0',
			yellow         = '#EBCB8B',
			special        = "#384356",
		}

		local custom_northern = require 'lualine.themes.northern'

		custom_northern.normal.c.bg = colors.dark
		custom_northern.insert.c.bg = colors.dark
		custom_northern.visual.c.bg = colors.dark
		custom_northern.replace.c.bg = colors.dark
		custom_northern.command.c.bg = colors.dark

		custom_northern.normal.b.bg = colors.special
		custom_northern.insert.b.bg = colors.special
		custom_northern.visual.b.bg = colors.special
		custom_northern.replace.b.bg = colors.special
		custom_northern.command.b.bg = colors.special

		require('lualine').setup {
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = custom_northern,
				component_separators = "",
				section_separators = { left = '', right = '' },
				ignore_focus = {},
				always_divide_middle = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
				disabled_filetypes = {
					statuslines = {},
					winbar = {},
					"alpha",
					"TelescopePrompt",
					"Telescope",
					"lazygit",
				},
			},
			sections = {
				lualine_a = {
					{
						'mode',
						fmt = function(str) return str:sub(1, 1) end,
						right_padding = 1
					},
				},
				lualine_b = {
					{
						'branch',
						icon = { '', color = { bg = colors.grey, fg = colors.green }, align = 'left' },
						color = { bg = colors.grey, fg = colors.yellow },
						separator = { right = '' },
					},
					{
						'filetype',
						icon_only = true,
						icon = { align = 'right' },
						colored = false,
					},
					{
						'filename',
						file_status = true,
						newfile_status = true,
						path = 0,
					},
				},
				lualine_c = {
					{
						'diagnostics',
						sources = { 'nvim_diagnostic', 'nvim_lsp' },
						sections = { 'error' },
						diagnostics_color = { error = { bg = colors.dark, fg = colors.red } },
						update_in_insert = true
					},
					{
						'diagnostics',
						sources = { 'nvim_diagnostic', 'nvim_lsp' },
						sections = { 'warn' },
						diagnostics_color = { warn = { bg = colors.dark, fg = colors.yellow } },
						update_in_insert = true
					},
					{
						'diagnostics',
						sources = { 'nvim_diagnostic', 'nvim_lsp' },
						sections = { 'hint' },
						diagnostics_color = { hint = { bg = colors.dark, fg = colors.frostturquoise } },
						update_in_insert = true
					},
					{
						'diagnostic-message',
						colors = {
							error = colors.red,
							warn = colors.yellow,
							info = colors.frostturquoise,
							hint = colors.frostturquoise,
						},
						icons = {
							error = "",
							warn = "",
							info = "",
							hint = "",
						},
					}
				},
				lualine_x = {
					{
						'diff',
						color = { bg = colors.dark }
					},
				},
				lualine_y = {
					"datetime",
				},
				lualine_z = {
					{
						"progress"
					},
					{
						'searchcount',
						icon = { '', color = { fg = colors.dark }, align = 'right' },
					},
					{
						'selectioncount',
						icon = { '󰒅', color = { fg = colors.dark }, align = 'right' },
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {
				'mason',
				'neo-tree',
				'nvim-dap-ui',
				'quickfix',
				'symbols-outline',
				'trouble'
			},
		}
	end
}
