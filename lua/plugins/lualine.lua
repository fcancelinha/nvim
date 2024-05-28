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

		local custom_northern = require('lualine.themes.northern')

		custom_northern.normal.c.bg = colors.dark
		custom_northern.insert.c.bg = colors.dark
		custom_northern.visual.c.bg = colors.dark
		custom_northern.replace.c.bg = colors.dark
		custom_northern.command.c.bg = colors.dark

		local empty = require('lualine.component'):extend()
		function empty:draw(default_highlight)
			self.status = ''
			self.applied_separator = ''
			self:apply_highlights(default_highlight)
			self:apply_section_separators()
			return self.status
		end

		local function modified()
			if vim.bo.modified then
				return '+'
			elseif vim.bo.modifiable == false or vim.bo.readonly == true then
				return '-'
			end
			return ''
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
					comp.separator = left and { right = '' } or { left = '' }
				end
			end
			return sections
		end

		require('lualine').setup {
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = custom_northern,
				component_separators = "",
				ignore_focus = {},
				section_separators = { left = '', right = '' },
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
					-- "TelescopePrompt",
					-- "Telescope",
					"lazygit",
				},
			},
			sections = process_sections {
				lualine_a = {
					{
						'mode',
						right_padding = 1
					},
				},
				lualine_b = {
					{
						'branch',
						icon = { ' ', color = { bg = colors.grey, fg = colors.green }, align = 'left' },
						color = { bg = colors.special, fg = colors.yellow },
					},
					{
						'diff',
						color = { bg = colors.dark }
					},
					{
						-- experimental
						function()
							return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
						end,
					},
				},
				lualine_c = {
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
				},
				lualine_y = {
					{
						'filetype',
						color = { bg = colors.dark },
						icon_only = false,
						icon = { align = 'left' },
						colored = true,
					},

					{
						modified,
						color = { bg = colors.special, fg = colors.red },
					},
					{
						"encoding"
					},
					{
						'filename',
						icon = { ' ', color = { bg = colors.grey, fg = colors.green }, align = 'left' },
						color = { bg = colors.special, fg = colors.snowdark },
						file_status = false,
						newfile_status = false,
						path = 1,
					},
				},
				lualine_z = {
					{
						'searchcount',
						icon = { '', color = { fg = colors.dark }, align = 'right' },
					},
					{
						'selectioncount',
						icon = { '󰒅', color = { fg = colors.dark }, align = 'right' },
					},
					{
						"location"
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
