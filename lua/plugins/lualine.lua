return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
	config = function ()
		local custom_nord = function ()
			local colors = {
				dark        = '#2E3440',
				grey = '#434C5E',
				frostblue = '#5E81Ac',
				frostgreen = '#8FBCBB',
				frostlightblue = '#81A1C1',
				frostturquoise = "#88C0D0",
				green        = '#A3BE8C',
				orange         = '#D08770',
				purple     = '#B48EAD',
				red          = '#BF616A',
				snowdark = '#D8DEE9',
				snowlight= '#ECEFF4',
				snowshade = '#E5E9F0',
				yellow       = '#EBCB8B',
			}

			return {
				normal = {
					a = {bg = colors.frostturquoise, fg = colors.dark, gui = 'bold'},
					b = {bg = colors.dark, fg = colors.snowlight},
					c = {bg = colors.dark, fg = colors.snowlight},
					x = {bg = colors.dark, fg = colors.frostturquoise},
					y = {bg = colors.grey, fg = colors.snowdark},
					z = {bg = colors.frostturquoise, fg = colors.dark, gui = 'bold'},
				},
				insert = {
					a = {bg = colors.green, fg = colors.dark, gui = 'bold'},
					b = {bg = colors.dark, fg = colors.snowlight},
					c = {bg = colors.dark, fg = colors.snowlight},
					x = {bg = colors.dark, fg = colors.green},
					y = {bg = colors.grey, fg = colors.snowdark},
					z = {bg = colors.green, fg = colors.dark, gui = 'bold'},
				},
				visual = {
					a = {bg = colors.frostblue, fg = colors.dark, gui = 'bold'},
					b = {bg = colors.dark, fg = colors.snowlight},
					c = {bg = colors.dark, fg = colors.snowlight},
					x = {bg = colors.dark, fg = colors.frostblue},
					y = {bg = colors.grey, fg = colors.snowdark},
					z = {bg = colors.frostblue, fg = colors.dark, gui = 'bold'},
				},
				replace = {
					a = {bg = colors.red, fg = colors.dark, gui = 'bold'},
					b = {bg = colors.dark, fg = colors.snowlight},
					c = {bg = colors.dark, fg = colors.snowlight},
					x = {bg = colors.dark, fg = colors.red},
					y = {bg = colors.grey, fg = colors.snowdark},
					z = {bg = colors.red, fg = colors.dark, gui = 'bold'},
				},
				command = {
					a = {bg = colors.yellow, fg = colors.dark, gui = 'bold'},
					b = {bg = colors.dark, fg = colors.snowlight},
					c = {bg = colors.dark, fg = colors.snowlight},
					x = {bg = colors.dark, fg = colors.yellow},
					y = {bg = colors.grey, fg = colors.snowdark},
					z = {bg = colors.yellow, fg = colors.dark, gui = 'bold'},
				},
				inactive = {
					a = {bg = colors.snowdark, fg = colors.dark, gui = 'bold'},
					b = {bg = colors.dark, fg = colors.snowlight},
					c = {bg = colors.dark, fg = colors.snowlight},
					x = {bg = colors.dark, fg = colors.snowdark},
					y = {bg = colors.snowlight, fg = colors.dark},
					z = {bg = colors.snowdark, fg = colors.dark, gui = 'bold'},
				}
			}
		end

		-- #2E3440

		require('lualine').setup({
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = custom_nord,
				component_separators = {left = "", right = ""},
				section_separators = {left="", right = ""},
				disabled_filetypes = {"alpha", "dashboard", "neo-tree", "neo-tree-popup"},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						padding = 2,
					}
				},
				lualine_b = {
					{
						"fileformat",
						colored = true
					},
					{
						"encoding",
						colored = true
					},
					{
						"searchcount",
						maxcount = 999,
						timeout =  500
					},
				},
				lualine_c = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic", "nvim_lsp" },
						sections = { "error", "warn", "info" },
						symbols = { error = " ", warn = "  ", info ="  "},
						colored = true,
						update_in_insert = true,
						always_visible = false,
						diagnostics_color = {
							error = 'DiagnosticError',
							warn = 'DiagnosticWarn',
							info = 'DiagnosticInfo',
						},
					},
				},
				lualine_x = {
					{
						"branch",
						colored = true,
					},
					{
						"diff",
						colored = true,
						symbols = { added = " ● ", modified = " ⦾ ", removed = " 🞊 " }, -- changes diff symbols
					},
				},
				lualine_y = {
					{
						"filetype",
						colored = true,
						icons_only = true,
					},
				},
				lualine_z = {
					{
						"location",
						padding = 1
					},
				},
			},

		})
	end,
}
