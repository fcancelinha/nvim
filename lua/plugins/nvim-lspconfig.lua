return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		-- Setup lspconfig	
		local lspconfig = require('lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local util = require('lspconfig/util')

		-- Misc Options
		require('lspconfig.ui.windows').default_options.border = 'single'

		-- Autoformat while attempting to use the registered LSP for that particular file
		vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

		vim.diagnostic.config({
			signs = true,
			underline = false,
			update_in_insert = true,
		})

		-- Change diagnostic signs.
		vim.fn.sign_define("DiagnosticSignError", { text = ' ', texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = ' ', texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = ' ', texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = '󰌵', texthl = "DiagnosticSignHint" })

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

		-- Setup Servers
		lspconfig.gopls.setup {
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					semanticTokens = true,
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
		}

		lspconfig.golangci_lint_ls.setup {
			capabilities = capabilities,
			cmd = { 'golangci-lint-langserver' },
			filetypes = { "go", "gomod" },
			init_options = {
				command = { "golangci-lint", "run", "--out-format", "json" }
			},
			root_dir = util.root_pattern('.golangci.yml', '.golangci.yaml', '.golangci.toml', '.golangci.json', 'go.work',
				'go.mod', '.git')
		}

		lspconfig.lua_ls.setup {
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
		}

		lspconfig.javascript.setup {
			capabilities = capabilities
		}

		lspconfig.tsserver.setup {
			capabilities = capabilities
		}

		lspconfig.jsonls.setup {
			capabilities = capabilities
		}

		lspconfig.markdown.setup {
			capabilities = capabilities
		}

		lspconfig.robotframework_ls.setup {
			capabilities = capabilities
		}

		lspconfig.yamlls.setup {
			capabilities = capabilities
		}
	end
}
