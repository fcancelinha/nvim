return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Setup lspconfig	
		local lspconfig = require('lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local util = require('lspconfig/util')

		-- Autoformat while attempting to use the registered LSP for that particular file
		vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

		vim.diagnostic.config({
			signs = true,
			underline = true,
			update_in_insert = true,
		})

		-- Change diagnostic signs.
		vim.fn.sign_define("DiagnosticSignError", { text = ' ', texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = ' ', texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = ' ', texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = '󰌵', texthl = "DiagnosticSignHint" })


		-- Setup Servers
		lspconfig.gopls.setup {
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
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

		lspconfig.tsserver.setup {
			capabilities = capabilities
		}

		lspconfig.jsonls.setup {
			capabilities = capabilities
		}

		lspconfig.lua_ls.setup {
			capabilities = capabilities,
			settings = {
				Lua = {
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
						}
					},
				},
			},
		}

		lspconfig.html.setup {
			capabilities = capabilities
		}

		lspconfig.cssls.setup {
			capabilities = capabilities
		}

		lspconfig.marksman.setup {
			capabilities = capabilities
		}

		lspconfig.bashls.setup {
			capabilities = capabilities
		}

		lspconfig.vimls.setup {
			capabilities = capabilities
		}
	end
}
