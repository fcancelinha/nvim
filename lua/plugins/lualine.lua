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

		local custom_nord = {
			normal = {
				a = { bg = colors.frostturquoise, fg = colors.dark, gui = 'bold' },
				b = {},
				c = {},
				x = {},
				y = {},
				z = { bg = colors.frostturquoise, fg = colors.dark },
			},
			insert = {
				a = { bg = colors.green, fg = colors.dark, gui = 'bold' },
				b = {},
				c = {},
				x = {},
				y = {},
				z = { bg = colors.green, fg = colors.dark, },
			},
			visual = {
				a = { bg = colors.frostgreen, fg = colors.dark, gui = 'bold' },
				b = {},
				c = {},
				x = {},
				y = {},
				z = { bg = colors.frostgreen, fg = colors.dark, },
			},
			replace = {
				a = { bg = colors.red, fg = colors.dark, gui = 'bold' },
				b = {},
				c = {},
				x = {},
				y = {},
				z = { bg = colors.red, fg = colors.dark, },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.dark, gui = 'bold' },
				b = {},
				c = {},
				x = {},
				y = {},
				z = { bg = colors.yellow, fg = colors.dark, },
			},
			inactive = {
				a = { bg = colors.dark, fg = colors.dark, },
				b = {},
				c = {},
				x = {},
				y = {},
				z = { bg = colors.dark, fg = colors.dark, },
			}
		}

		local empty = require('lualine.component'):extend()
		function empty:draw(default_highlight)
			self.status = ''
			self.applied_separator = ''
			self:apply_highlights(default_highlight)
			self:apply_section_separators()
			return self.status
		end

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

		-- Put proper separators and gaps between components in sections
		local function process_sections(sections)
			for name, section in pairs(sections) do
				local left = name:sub(9, 10) < 'x'
				for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
					table.insert(section, pos * 2, { empty, color = { fg = colors.dark, bg = colors.dark } })
				end
				for id, comp in ipairs(section) do
					if type(comp) ~= 'table' then
						comp = { comp }
						section[id] = comp
					end
					comp.separator = left and { right = '' } or { left = '' }
				end
			end
			return sections
		end

		local function modified()
			if vim.bo.modified then
				return '+'
			elseif vim.bo.modifiable == false or vim.bo.readonly == true then
				return '-'
			end
			return ''
		end

		require('lualine').setup {
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = custom_nord,
				component_separators = '',
				section_separators = { left = '', right = '' },
				disabled_filetypes = {
					"alpha",
					"TelescopePrompt",
					"neo-tree",
					"neo-tree-popup",
					"lazygit"
				},
			},
			sections = process_sections {
				lualine_a = {
					{
						'mode',
					}
				},
				lualine_b = {
					{
						'filename',
						icon = { ' ', color = { bg = colors.grey, fg = colors.green }, align = 'left' },
						file_status = false,
						path = 4,
						color = { bg = colors.greydark, fg = colors.snowlight }
					},
					{
						'branch',
						icon = { ' ', color = { bg = colors.grey, fg = colors.green }, align = 'left' },
						color = { bg = colors.greydark, fg = colors.snowlight },
					}
				},
				lualine_c = {
					{
						'diagnostics',
						source = { 'nvim_diagnostic', 'nvim_lsp' },
						sections = { 'error' },
						diagnostics_color = { error = { bg = colors.red, fg = colors.snowlight } },
					},
					{
						'diagnostics',
						source = { 'nvim_diagnostic', 'nvim_lsp' },
						sections = { 'warn' },
						diagnostics_color = { warn = { bg = colors.yellow, fg = colors.snowlight } },
					},
					{
						'diagnostics',
						source = { 'nvim_diagnostic', 'nvim_lsp' },
						sections = { 'hint' },
						diagnostics_color = { hint = { bg = colors.frostlightblue, fg = colors.snowlight } },
					},
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
					{
						modified,
						color = { bg = colors.red },
					},
				},
				lualine_x = {
					{
						"diff",
						colored = true
					},
					{
						lsp_server,
						icon = { '󰒋  ', color = { bg = colors.grey, fg = colors.green }, align = 'left' },
						color = { bg = colors.greydark, fg = colors.snowlight }
					},
				},
				lualine_y = {
					{
						"encoding",
						color = { bg = colors.greydark, fg = colors.snowlight }

					},
					{
						'filetype',
						color = { bg = colors.greydark, fg = colors.snowlight },
						icon = { align = 'left' },
					},
				},
				lualine_z = {
					{
						"searchcount",
						icon = { ' ', color = { bg = colors.grey, fg = colors.green }, align = 'left' },
						color = { bg = colors.greydark, fg = colors.snowlight }
					},
					{
						"selectioncount",
						icon = { '󰒅 ', color = { bg = colors.grey, fg = colors.green }, align = 'left' },
					},
					{
						"location",
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
			extensions = {
				'quickfix',
				'nvim-dap-ui',
				'symbols-outline',
				'neo-tree',
			},
		}
	end
}
