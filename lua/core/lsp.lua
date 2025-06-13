-- for iterative collection of lsp server files
-- local servers_path = vim.fn.stdpath('config') .. '/lua/plugins/servers'
-- local server_files = vim.fn.globpath(servers_path, '*.lua', false, true)

vim.lsp.enable({
    'lua_ls',
    'gopls',
    'golangci_lint_ls',
    'sourcekit',
})

-- Set diagnostic icons (use Nerd Font icons or others you like)
local signs = {
    { name = 'DiagnosticSignError', text = ' ' },
    { name = 'DiagnosticSignWarn', text = ' ' },
    { name = 'DiagnosticSignInfo', text = ' ' },
    { name = 'DiagnosticSignHint', text = '󰌵 ' },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
        text = sign.text,
        texthl = sign.name,
        numhl = ''
    })
end

vim.diagnostic.config({
    underline = true,
    update_in_insert = true,
    virtual_text = true,
    severity_sort = false,
    virtual_lines = false,
    float = {
        border = 'rounded',
        focusable = true,
    },
    signs = true,
})
