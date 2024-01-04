return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			'VonHeikemen/lsp-zero.nvim',
			branch = 'v3.x'
		},
		{
			"williamboman/mason.nvim",
			dependencies = {
				{ "jay-babu/mason-nvim-dap.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },
				{ "williamboman/nvim-lsp-installer" },
			},
			build = ":MasonUpdate",
		},
	},
	config = function()
		require('lspconfig.ui.windows').default_options.border = 'single'

		-- Setup lspconfig	
		local lsp_zero = require('lsp-zero')
		local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

		lsp_zero.on_attach(function(_, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
			lsp_zero.buffer_autoformat()
		end)

		vim.diagnostic.config({
			signs = true,
			underline = false,
			update_in_insert = true,
		})

		-- Change diagnostic signs.
		lsp_zero.set_sign_icons({
			error = '◆',
			warn = '◈',
			info = '◇',
			hint = '󰌵',
		})

		require('mason').setup({
			ui = {
				check_outdated_packages_on_open = false,
				border = "single",
				width = 0.8,
				height = 0.9,
				icons = {
					package_installed = "◍",
					package_pending = "◍",
					package_uninstalled = "◍",
				},
				keymaps = {
					toggle_package_expand = "<CR>",
					install_package = "i",
					update_package = "u",
					check_package_version = "c",
					update_all_packages = "U",
					check_outdated_packages = "C",
					uninstall_package = "X",
					cancel_installation = "<C-c>",
					apply_language_filter = "<C-f>",
				},
			},
		})

		require('mason-lspconfig').setup({
			ensure_installed = { 'gopls', 'lua_ls' },
			capabilities = capabilities,
			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					require('lspconfig').lua_ls.setup({
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								diagnostics = {
									globals = {
										'vim',
										'require',
										'enable',
										'ls',
									},
								},
								telemetry = {
									enable = false,
								},
								format = {
									defaultConfig = {
										indent_style = 'tab',
										indent_size = '4',
									},
								},
							},
						},
					})
				end,
				gopls = function()
					require('lspconfig').gopls.setup({
						cmd = { "gopls" },
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						settings = {
							gopls = {
								semanticTokens = false,
								gofumpt = true,
								completeUnimported = true,
								usePlaceholders = true,
								analyses = {
									unusedparams = true,
								},
								codelenses = {
									generate = true,
								}
							},
						},
					})
				end,
			}
		})
	end
}
