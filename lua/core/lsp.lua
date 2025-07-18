-- for iterative collection of lsp server files
-- local servers_path = vim.fn.stdpath('config') .. '/lua/plugins/servers'
-- local server_files = vim.fn.globpath(servers_path, '*.lua', false, true)


vim.lsp.enable({
    'lua_ls',
    'ts_ls',
    'yamlls',
    'gopls',
    'golangci_lint_ls',
})
