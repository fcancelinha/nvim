vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = 'Yank', timeout = 200 })
	end,
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

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("goimports", {}),
	pattern = "*.go",
	callback = function()
		require('go.format').goimports()
	end,
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(event)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local lsp_opts = { buffer = event.buf, silent = true, noremap = true }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, lsp_opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, lsp_opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, lsp_opts)
		vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, lsp_opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, lsp_opts)
		vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, lsp_opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, lsp_opts)
	end,
})
