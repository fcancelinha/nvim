-- for iterative collection of lsp server files
-- local servers_path = vim.fn.stdpath('config') .. '/lua/plugins/servers'
-- local server_files = vim.fn.globpath(servers_path, '*.lua', false, true)

vim.lsp.enable({
    'lua_ls',
    'gopls',
})

vim.diagnostic.config({
    underline = true,
    update_in_insert = true,
    virtual_text = true,
    severity_sort = false,
    -- virtual_lines = false,
    float = {
        border = 'rounded',
        focusable = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✸ ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        }
    }
})
