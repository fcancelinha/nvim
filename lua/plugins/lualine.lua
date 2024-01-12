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
				section_separators = { left = '', right = '' },
				disabled_filetypes = {
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
					{ 'mode', separator = { right = '', left = '' }, right_padding = 1 },
				},
				lualine_b = {
					{
						'branch',
						icon = { '', color = { bg = colors.dark, fg = colors.green }, align = 'left' },
						color = { bg = colors.dark, fg = colors.yellow },
					},
					{
						'filename',
						path = 1,
						file_status = true,
						color = { bg = colors.dark, fg = colors.snowdark },
						icon = { '', color = { bg = colors.dark, fg = colors.green }, align = 'left' },
					},
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
				lualine_c = {
					{
						'%w',
						cond = function()
							return vim.wo.previewwindow
						end,
						color = { bg = colors.red },
					},
					{
						'%r',
						cond = function()
							return vim.bo.readonly
						end,
						color = { bg = colors.red },
					},
					{
						'%q',
						cond = function()
							return vim.bo.buftype == 'quickfix'
						end,
						color = { bg = colors.yellow },
					},
				},
				lualine_x = {
					{
						"diff",
						color = { bg = colors.dark },
					},
				},
				lualine_y = {
					{
						"encoding",
						color = { bg = colors.dark }
					},
					{
						'filetype',
						color = { bg = colors.dark },
						colored = true,
						icon_only = false,
						icon = { align = 'right' },
					},
				},
				lualine_z = {
					{
						"searchcount",
						icon = { '', color = { fg = colors.dark }, align = 'right' },
						separator = { right = '', left = '' }
					},
					{
						"selectioncount",
						icon = { '󰒅', color = { fg = colors.dark }, align = 'right' },
						separator = { right = '', left = '' }
					},
				},
			},
			tabline = {},
			extensions = {
				'quickfix',
				'nvim-dap-ui',
				'symbols-outline',
				'neo-tree',
			},
		}
	end
}
