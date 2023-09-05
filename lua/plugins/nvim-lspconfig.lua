return {
	"neovim/nvim-lspconfig",

	config = function()
		-- Setup lspconfig	
		local lspconfig = require('lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		local util = require('lspconfig/util')

		local border = {
			{ "🭽", "FloatBorder" },
			{ "▔", "FloatBorder" },
			{ "🭾", "FloatBorder" },
			{ "▕", "FloatBorder" },
			{ "🭿", "FloatBorder" },
			{ "▁", "FloatBorder" },
			{ "🭼", "FloatBorder" },
			{ "▏", "FloatBorder" },
		}

		-- LSP settings (for overriding per client)
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		}

		-- Setup Servers
		lspconfig.gopls.setup {
			capabilities = capabilities,
			handlers = handlers,
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

		lspconfig.tsserver.setup {
			capabilities = capabilities
		}

		lspconfig.jsonls.setup {
			capabilities = capabilities
		}

		lspconfig.lua_ls.setup {
			capabilities = capabilities,
			handlers = handlers,
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

		-- Run lua lsp format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.lua",
			callback = function()
				vim.lsp.buf.format()
			end,
		})

		-- Run gofmt + goimport on save
		local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require('go.format').goimport()
			end,
			group = format_sync_grp,
		})
	end
}
