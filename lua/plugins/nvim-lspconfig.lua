return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"williamboman/mason-lspconfig.nvim",
		"junnplus/lsp-setup.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		-- capabilities.textDocument.completion.completionItem.snippetSupport = true

		vim.api.nvim_create_autocmd('TextYankPost', {
			group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
			callback = function()
				vim.highlight.on_yank({ higroup = 'Yank', timeout = 200 })
			end,
			desc = "Highlight text on yank"
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require('go.format').goimports()
			end,
			group = vim.api.nvim_create_augroup("goimports", {}),
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.lua,*.json,*.yaml,*.yml,*.css,*.scss,*.html,*.xml,*.sh",
			command = "lua vim.lsp.buf.format()",
		})

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = ".gitlab*",
			callback = function()
				vim.bo.filetype = "yaml.gitlab"
			end,
		})

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = "*.robot",
			callback = function()
				vim.bo.filetype = "robot"
			end,
		})

		vim.diagnostic.config({
			signs = true,
			underline = false,
			update_in_insert = true,
			severity_sort = true,
		})

		require('mason').setup({
			ui = {
				check_outdated_packages_on_open = true,
				border = "rounded",
				width = 80,
				height = 0.9,
			},
		})

		require("lsp-setup").setup({
			capabilities = capabilities,
			servers = {
				lua_ls = {
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
				},
				gopls = {
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
				},
				tsserver = {},
				angularls = {
					root_dir = require("lspconfig.util").root_pattern('angular.json', 'project.json'),
				},
				jsonls = {
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
				},
				yamlls = {
					settings = {
						redhat = {
							telemetry = {
								enable = false,
							},
						},
						yaml = {
							format = {
								enable = true,
								singleQuote = false,
								bracketSpacing = true,
							},
							schemaStore = {
								enable = true,
							},
							validate = true,
							completion = true,
						}
					}
				},
				eslint = {
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
				},
				bashls = {
					name = 'bash-language-server',
					cmd = { 'bash-language-server', 'start' },
					filetypes = { 'sh' }
				},
				gitlab_ci_ls = {
					filetypes = { "gitlab*" }
				},
				cssls = {},
				marksman = {},
				robotframework_ls = {
					cmd = { "/home/fc/.local/bin/robotframework_ls" },
					settings = {
						robot = {
							pythonpath = "/usr/src/python3",
							lint = {
								enabled = true,
								robocop = {
									enabled = true
								}
							}
						}
					}
				}
			}
		})

		vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = "DiagnosticSignError" })
		vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = "DiagnosticSignInformation" })
		vim.fn.sign_define('DiagnosticSignHint', { text = '󱧣 ', texthl = "DiagnosticSignHint" })
	end,
}
