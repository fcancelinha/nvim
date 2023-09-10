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
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require('cmp')

			cmp.setup({
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
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<Tab>'] = cmp.mapping.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Insert,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.
					{ name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
					{ name = 'nvim_lsp_document_symbol' },
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'path' }
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
		end
	},
}
