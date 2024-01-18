return {
	"nvim-lualine/lualine.nvim",
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
					"neo-tree",
					"neo-tree-popup",
					"lazygit",
					"toggleterm"
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
						icon = { '', color = { bg = colors.special, fg = colors.green }, align = 'left' },
						color = { bg = colors.special, fg = colors.yellow },
						separator = { right = '' },
					},
					{
						"diff",
						color = { bg = colors.special },
						separator = { right = '' },
					},
				},
				lualine_c = {
					{
						'diagnostics',
						source = { 'nvim_diagnostic', 'nvim_lsp' },
						sections = { 'error' },
						diagnostics_color = { error = { bg = colors.dark, fg = colors.red } },

					},
					{
						'diagnostics',
						source = { 'nvim_diagnostic', 'nvim_lsp' },
						sections = { 'warn' },
						diagnostics_color = { warn = { bg = colors.dark, fg = colors.yellow } },
					},
					{
						'diagnostics',
						source = { 'nvim_diagnostic', 'nvim_lsp' },
						sections = { 'hint' },
						diagnostics_color = { hint = { bg = colors.dark, fg = colors.frostturquoise } },
					},
				},
				lualine_x = {
					{
						"encoding",
						color = { bg = colors.special },
					},
				},
				lualine_y = {
					{
						'filename',
						path = 1,
						file_status = true,
						color = { bg = colors.special, fg = colors.snowdark },
						icon = { '', color = { bg = colors.special, fg = colors.green }, align = 'left' },
					},
					{
						'filetype',
						fmt = function(str) return '[' .. str .. ']' end,
						color = { bg = colors.special },
						colored = true,
						icon = { align = 'right' },
						icons_enabled = false,
					},
				},
				lualine_z = {
					{
						"searchcount",
						icon = { '', color = { fg = colors.dark }, align = 'right' },
					},
					{
						"selectioncount",
						icon = { '󰒅', color = { fg = colors.dark }, align = 'right' },
					},
					{
						'progress'
					}
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
				'quickfix',
				'nvim-dap-ui',
				'symbols-outline',
				'neo-tree',
			},
		}
	end
}
