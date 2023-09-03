return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		lazy = false,
		dependencies = {
			"Jezda1337/nvim-html-css",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-git",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"ray-x/cmp-treesitter",
			"hrsh7th/cmp-nvim-lua",
		},
		config = function()

			local cmp = require'cmp'

			local nord_yellow = "#EBCB8B"
			local nord_green  = "#A3BE8C"
			local nord_purple = "#B48EAD"
			local nord_red = "#BF616A"
			local nord_grey = "#D8DEE9"
			local nord_light_green = "#8FBCBB"
			local nord_light_blue = "#88C0D0"
			local nord_light_cyan = "#81A1C1"

			--CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
			--CmpItemKindKeyword = { fg = C.base, bg = C.red },
			--CmpItemKindText = { fg = C.base, bg = C.teal },
			--CmpItemKindMethod = { fg = C.base, bg = C.blue },
			--CmpItemKindConstructor = { fg = C.base, bg = C.blue },
			--CmpItemKindFunction = { fg = C.base, bg = C.blue },
			--CmpItemKindFolder = { fg = C.base, bg = C.blue },
			--CmpItemKindModule = { fg = C.base, bg = C.blue },
			--CmpItemKindConstant = { fg = C.base, bg = C.peach },
			--CmpItemKindField = { fg = C.base, bg = C.green },
			--CmpItemKindProperty = { fg = C.base, bg = C.green },
			--CmpItemKindEnum = { fg = C.base, bg = C.green },
			--CmpItemKindUnit = { fg = C.base, bg = C.green },
			--CmpItemKindClass = { fg = C.base, bg = C.yellow },
			--CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
			--CmpItemKindFile = { fg = C.base, bg = C.blue },
			--CmpItemKindInterface = { fg = C.base, bg = C.yellow },
			--CmpItemKindColor = { fg = C.base, bg = C.red },
			--CmpItemKindReference = { fg = C.base, bg = C.red },
			--CmpItemKindEnumMember = { fg = C.base, bg = C.red },
			--CmpItemKindStruct = { fg = C.base, bg = C.blue },
			--CmpItemKindValue = { fg = C.base, bg = C.peach },
			--CmpItemKindEvent = { fg = C.base, bg = C.blue },
			--CmpItemKindOperator = { fg = C.base, bg = C.blue },
			--CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
			--CmpItemKindCopilot = { fg = C.base, bg = C.teal },

			-- Format cmp window colors
			-- gray
			vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg=nord_grey })
			vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
			vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg=nord_light_blue})
			vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { bg='NONE', fg=nord_yellow})
			vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
			vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg=nord_light_blue })
			vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
			vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg=nord_light_blue})
			vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
			vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })
			vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { bg='NONE', fg=nord_red })
			vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { bg='NONE', fg=nord_yellow })
			vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { bg='NONE', fg=nord_purple })
			vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { bg='NONE', fg=nord_purple })
			vim.api.nvim_set_hl(0, 'CmpItemKindModule', { bg='NONE', fg=nord_green })
			vim.api.nvim_set_hl(0, 'CmpItemKindField', { bg='NONE', fg=nord_light_cyan })
			vim.api.nvim_set_hl(0, 'CmpItemKindClass', { bg='NONE', fg=nord_light_cyan })

			vim.cmd[[	
			highlight! BorderBG guibg=NONE guifg=#88C0D0
			]]

			local kind_icons = {
				Text = "",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰇽",
				Variable = "󰂡",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			}

			cmp.setup({
				formatting =  {
					fields = {"kind", "abbr", "menu"},
					format = function (entry, vim_item)
						-- Kind icons
						vim_item.kind = string.format('%s', kind_icons[vim_item.kind]) -- This concatonates the icons with the name of the item kind
						-- Source
						vim_item.menu = ({
							buffer = "",
							nvim_lsp = "",
							nvim_lua = "",
							luasnip = "",
							latex_symbols = "",
						})[entry.source.name]
						return vim_item
					end
				},
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
					}),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-j>'] = cmp.mapping.select_next_item(),
					['<C-k>'] = cmp.mapping.select_prev_item(),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<cr-space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({
						select = false,
						behavior = cmp.ConfirmBehavior.Replace,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.
					{ name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
					{ name = 'treesitter'},
					{ name = 'nvim_lua'},
				}, {
					{ name = 'buffer' },
				})
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
				}, {
					{ name = 'buffer' },
				})
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})

		end
	},
}
