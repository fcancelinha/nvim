-- for iterative collection of lsp server files
local servers_path = vim.fn.stdpath('config') .. '/lsp/'
local server_files = vim.fn.globpath(servers_path, '*.lua', false, true)

local dynamic_servers = {}
for _, file_path in ipairs(server_files) do
    local filename = vim.fn.fnamemodify(file_path, ':t:r')
    table.insert(dynamic_servers, filename)
end

local manual_servers = {
    'bashls',
    'docker_compose_language_service',
    'docker_language_server',
    'golangci_lint_ls',
    'vscode-eslint-language-server',
}

-- Set up capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Shared on_attach function
local on_attach = function(client, bufnr)
    -- Format on save if the LSP supports it
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
            end,
        })
    end
end

-- Combine all servers
local all_servers = vim.list_extend(dynamic_servers, manual_servers)
vim.lsp.enable(all_servers)

-- Set up the on_attach for all LSP clients
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            on_attach(client, args.buf)
        end
    end,
})
