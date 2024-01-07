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
		-- Auto-format
		vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				local opts = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = 'single',
					source = 'always',
					prefix = ' ',
					scope = 'cursor',
				}
				vim.diagnostic.open_float(nil, opts)
			end
		})

		-- Setup lspconfig	
		local lsp_zero = require('lsp-zero')
		local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
		local lspconfig = require("lspconfig")

		lsp_zero.on_attach(function(_, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
		end)

		vim.diagnostic.config({
			signs = true,
			underline = false,
			update_in_insert = true,
			severity_sort = true,
		})

		-- Change diagnostic signs.
		lsp_zero.set_sign_icons({
			error = '◆',
			warn = '◈',
			info = '◇',
			hint = '󰌵',
		})

		require('lspconfig.ui.windows').default_options.border = 'single'

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
					lspconfig.lua_ls.setup({
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
									enable = true,
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
					lspconfig.gopls.setup({
						cmd = { "gopls" },
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						settings = {
							gopls = {
								semanticTokens = true,
								gofumpt = true,
								completeUnimported = true,
								usePlaceholders = false,
								codelenses = {
									gc_details         = true,
									generate           = true,
									run_govulncheck    = true,
									test               = true,
									tidy               = true,
									upgrade_dependency = true,
								},
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
								analyses = {
									nilness = true,
									unusedparams = true,
									unusedvariable = true,
									unusedwrite = true,
									useany = true
								},
								staticcheck = true,
								directoryFilters = { "-.git", "-node_modules" },
							},
						},
						flags = {
							debounce_text_changes = 150,
						}
					})
				end,
				yamlls = function()
					lspconfig.yamlls.setup({
						schemaStore = {
							url = "https://www.schemastore.org/api/json/catalog.json",
							enable = true,
						},
					})
				end
			}
		})
	end
}
