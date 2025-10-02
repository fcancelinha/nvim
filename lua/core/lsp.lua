-- for iterative collection of lsp server files
local servers_path = vim.fn.stdpath('config') .. '/lsp/'
local server_files = vim.fn.globpath(servers_path, '*.lua', false, true)

local dynamic_servers = {}
for _, file_path in ipairs(server_files) do
    local filename = vim.fn.fnamemodify(file_path, ':t:r')
    table.insert(dynamic_servers, filename)
end

local manual_servers = {
    'docker_compose_language_service',
    'docker_language_server',
    'golangci_lint_ls',
    'vscode-eslint-language-server',
    'bashls',
}

vim.lsp.enable(vim.list_extend(dynamic_servers, manual_servers))
