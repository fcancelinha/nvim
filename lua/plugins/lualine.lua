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

		custom_northern.normal.c.bg = "#2E3440"
		custom_northern.insert.c.bg = "#2E3440"
		custom_northern.visual.c.bg = "#2E3440"
		custom_northern.replace.c.bg = "#2E3440"
		custom_northern.command.c.bg = "#2E3440"


		-- Lsp server name .
		local function lsp_server()
			local msg = '[NOLSP]'
			local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
			local clients = vim.lsp.get_active_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end

		require('lualine').setup {
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = custom_northern,
				component_separators = '',
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
					{ 'mode', separator = { left = '', right = '' }, right_padding = 2 },
				},
				lualine_b = {
					{
						'branch',
						icon = { '', color = { bg = colors.greydark, fg = colors.green }, align = 'left' },
						color = { bg = colors.greydark, fg = colors.yellow },
						separator = { right = '' }
					},
					{
						'filename',
						icon = { '', color = { bg = colors.dark, fg = colors.green }, align = 'left' },
						file_status = true,
						newfile_status = true,
						path = 1,
						color = { bg = colors.dark },
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
					{
						"diff",
						color = { bg = colors.dark },
					},
					{
						lsp_server,
						icon = { '󰒋', color = { bg = colors.dark, fg = colors.green }, align = 'right' },
						color = { bg = colors.dark },
						separator = { left = '' }
					},
				},
				lualine_y = {
					{
						"encoding",
					},
					{
						'filetype',
						color = { bg = colors.greydark },
						icon = { align = 'right' },
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
						'location', separator = { left = '', right = '' }, left_padding = 1,
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
