-- mason-lspconfig is gone: lua/core/lsp.lua owns vim.lsp.config/enable for
-- everything under lsp/. Mason is only a binary installer here, so the
-- packages it used to pull in implicitly are listed explicitly instead.
local ensure_installed = {
    'autotools-language-server',
    'basedpyright',
    'copilot-language-server',
    'debugpy',
    'delve',
    'gofumpt',
    'goimports',
    'golangci-lint',
    'golangci-lint-langserver',
    'gopls',
    'json-lsp',
    'lua-language-server',
    'marksman',
    'mdformat',
    'ruff',
}

vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

require('mason').setup({
    ui = {
        border = 'rounded',
        width = 0.5,
    }
})

require('mason-nvim-dap').setup({
    ensure_installed = { 'delve', 'debugpy' },
    automatic_installation = true,
    handlers = {},
})

-- Install anything missing in the background once the registry is ready.
local registry = require('mason-registry')

registry.refresh(function()
    for _, name in ipairs(ensure_installed) do
        local ok, pkg = pcall(registry.get_package, name)
        if ok and not pkg:is_installed() then
            pkg:install()
        end
    end
end)
