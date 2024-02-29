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
			},
			build = ":MasonUpdate",
		}
	},
	config = function()
		-- Setup lspconfig	
		local lsp_zero = require('lsp-zero')
		local lspconfig = require("lspconfig")
		local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

		-- Auto-format & Default keymaps
		lsp_zero.on_attach(function(_, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.lua,*.json,*.yaml,*.css,*.html,*.xml",
				command = "lua vim.lsp.buf.format()",
			})
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
			ensure_installed = { 'gopls', 'lua_ls', 'tsserver' },
			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
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
										'actions',
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
						capabilities = capabilities,
						cmd = { "gopls" },
						fillstruct = 'gopls',
						dap_debug = true,
						dap_debug_gui = true,
						filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl" },
						message_level = vim.lsp.protocol.MessageType.Error,
						settings = {
							gopls = {
								experimentalPostfixCompletions = true,
								semanticTokens = true,
								gofumpt = true,
								completeUnimported = true,
								usePlaceholders = false,
								staticcheck = true,
								matcher = 'Fuzzy',
								symbolMatcher = 'fuzzy',
								diagnosticsDelay = '500ms',
								codelenses = {
									gc_details         = true,
									generate           = true,
									run_govulncheck    = true,
									test               = true,
									tidy               = true,
									upgrade_dependency = true,
									regenerate_cgo     = true,
									vendor             = true,
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
									useany = true,
									unreachable = true,
									ST1003 = true,
									undeclaredname = true,
									nonewvars = true,
									fieldalignment = false,
									shadow = true,
									fillreturns = true,
								},
								directoryFilters = { "-.git", "-node_modules", "-.idea", "-.vscode-test", "-.vscode" },
								buildFlags = { '-tags', 'integration' },
							},
						},
						init_options = {
							usePlaceholders = true,
						},
						flags = {
							debounce_text_changes = 500,
							allow_incremental_sync = true,
						}
					})
				end,
				yamlls = function()
					lspconfig.yamlls.setup({
						capabilities = capabilities,
						schemaStore = {
							url = "https://www.schemastore.org/api/json/catalog.json",
							enable = true,
						},
					})
				end,
				eslint = function()
					lspconfig.eslint.setup({
						capabilities = capabilities,
						on_attach = function(_, bufnr)
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								command = "EslintFixAll",
							})
						end,
						flags = {
							debounce_text_changes = 150,
						},
						cmd = { "vscode-eslint-language-server", "--stdio" },
						filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
						handlers = {
							["eslint/confirmESLintExecution"] = function()
								-- vim.cmd [[echom "confirmESLintExecution"]]
								vim.notify("ESLint executing.", vim.log.levels.INFO)
								return {}
							end,
							["eslint/openDoc"] = function()
								-- vim.cmd [[echom "openDoc"]]
								vim.notify("Opening ESLint docs.", vim.log.levels.INFO)
								return {}
							end,
							["eslint/probeFailed"] = function()
								vim.notify("ESLint probe failed.", vim.log.levels.WARN)
								return {}
							end,
							["eslint/noLibrary"] = function()
								vim.notify("Unable to find ESLint library.", vim.log.levels.WARN)
								return {}
							end,
						},
						on_new_config = function(config, new_root_dir)
							-- The "workspaceFolder" is a VSCode concept. It limits how far the
							-- server will traverse the file system when locating the ESLint config
							-- file (e.g., .eslintrc).
							config.settings.workspaceFolder = {
								uri = new_root_dir,
								name = vim.fn.fnamemodify(new_root_dir, ':t'),
							}
						end,
						settings = {
							codeAction = {
								disableRuleComment = {
									enable = true,
									location = "separateLine",
								},
								showDocumentation = {
									enable = true,
								}
							},
							codeActionOnSave = {
								enable = true,
								mode = "all"
							},
							format = true,
							nodePath = "",
							onIgnoredFiles = "off",
							packageManager = "npm",
							quiet = false,
							rulesCustomizations = {
								{
									rule = "no-unused-vars",
									severity = "off",
								},
							},
							run = "onType",
							useESLintClass = false,
							validate = "on",
							workingDirectory = {
								mode = "location"
							}
						}
					})
				end,
			}
		})
	end,
}
