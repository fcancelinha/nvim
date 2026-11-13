-- Neovim loads lsp/<name>.lua off the runtimepath itself, so this file only has
-- to supply the shared capabilities and name the servers to enable.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Merged into every server config, including the ones under lsp/.
vim.lsp.config('*', { capabilities = capabilities })

-- Servers that need no configuration beyond the defaults.
local servers = {
    'html',
    'cssls',
    'bashls',
    'graphql',
    'docker_language_server',
    'docker_compose_language_server',
}

for _, path in ipairs(vim.fn.globpath(vim.fn.stdpath('config') .. '/lsp', '*.lua', false, true)) do
    servers[#servers + 1] = vim.fn.fnamemodify(path, ':t:r')
end

vim.lsp.enable(servers)
