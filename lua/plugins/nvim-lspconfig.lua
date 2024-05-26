return {
	"neovim/nvim-lspconfig",
	dependencies = {
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
		local lspconfig = require("lspconfig")
		local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
		local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})

		require('lspconfig.ui.windows').default_options.border = 'single'

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require('go.format').goimports()
			end,
			group = format_sync_grp,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.lua,*.json,*.yaml,*.css,*.html,*.xml",
			command = "lua vim.lsp.buf.format()",
		})

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = ".gitlab*",
			callback = function()
				vim.bo.filetype = "yaml.gitlab"
			end,
		})

		-- Change diagnostic signs.
		vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = "DiagnosticSignError" })
		vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define('DiagnosticSignInfo', { text = '󰋼 ', texthl = "DiagnosticSignInformation" })
		vim.fn.sign_define('DiagnosticSignHint', { text = ' ', texthl = "DiagnosticSignHint" })

		vim.diagnostic.config({
			signs = true,
			underline = false,
			update_in_insert = true,
			severity_sort = true,
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
			ensure_installed = { 'gopls', 'lua_ls', 'tsserver' },
			handlers = {
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
				jsonls = function()
					lspconfig.jsonls.setup({
						capabilities = capabilities,
						settings = {
							json = {
								format = {
									enable = true
								},
								schemas = {
									{
										fileMatch = { 'package.json' },
										url = 'https://json.schemastore.org/package.json',
									},
									{
										fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
										url = 'https://json.schemastore.org/tsconfig',
									},
									{
										fileMatch = { 'eslintrc.json' },
										url = 'https://json.schemastore.org/eslintrc.json',
									},
								},
							},
							validate = {
								enable = true
							}
						},
					})
				end,
				yamlls = function()
					lspconfig.yamlls.setup({
						capabilities = capabilities,
						yaml = {
							validate = true,
							schemaStore = {
								url = "https://www.schemastore.org/api/json/catalog.json",
								enable = true,
							},
							editor = {
								tabsize = 4,
								formatOnType = true,
							},
						}
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
				robotframework_ls = function()
					lspconfig.robotframework_ls.setup({
						capabilities = capabilities,
						settings = {
							robot = {
								pythonpath = { "${workspaceFolder}/libraries" },
								codeFormatter = true,
								codeLens = {
									enable = true
								},
								lint = {
									enabled = true,
									robocop = {
										enabled = true,
									},
								}

							}
						}
					})
				end,
				bashls = function()
					lspconfig.bashls.setup({
						capabilities = capabilities,
						name = "bash",
						cmd = { 'bash-language-server', 'start' },
						filetypes = { 'sh' }
					})
				end,
				gitlab_ci_ls = function()
					lspconfig.gitlab_ci_ls.setup({
						capabilities = capabilities,
					})
				end
			}
		})
	end,
}
