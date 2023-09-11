return {
	"hrsh7th/nvim-cmp",
	-- event = "InsertEnter",
	lazy = false,
	dependencies = {
		"Jezda1337/nvim-html-css",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-git",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",
		"ray-x/cmp-treesitter",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require('cmp')

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			formatting = {
				fields = { "kind", "menu", "abbr" },
				format = function(entry, vim_item)
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

					-- Kind icons
					vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kinde
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
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
					border = "single",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "Normal:Normal,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
					border = "single",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-j>'] = cmp.mapping.select_next_item(),
				['<C-k>'] = cmp.mapping.select_prev_item(),
				["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-e>"] = cmp.mapping.close(),
				['<Tab>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp', max_item_count = 10 },
				{ name = 'nvim_lua', max_item_count = 10 },
				{ name = 'luasnip' }, -- For luasnip users.
				{ name = 'path' },
				{ name = 'buffer' },
			})
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'buffer' },
				{ name = 'git' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			formatting = {
				fields = { 'abbr' },
			},
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			formatting = {
				fields = { 'abbr' },
			},
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
		})

		-- Database completion
		vim.api.nvim_exec([[" autocmd! FileType sql setlocal omnifunc=vim_dadbod_completion#omni
		autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
		]], false)
	end,
}
