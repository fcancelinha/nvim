-- mason-lspconfig is gone: lua/core/lsp.lua owns vim.lsp.config/enable for
-- everything under lsp/. Mason is only a binary installer here, so the packages
-- it used to pull in implicitly are listed explicitly instead.
return {
    src = 'mason-org/mason.nvim',
    deps = {
        'jay-babu/mason-nvim-dap.nvim',
    },
    priority = 80, -- prepends the mason bin dir to PATH before other tools look
    config = function()
        local ensure_installed = {
            'copilot-language-server',
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
        }

        vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

        require('mason').setup({
            ui = {
                border = 'rounded',
                width = 0.5,
            }
        })

        require('mason-nvim-dap').setup({
            ensure_installed = { 'delve' },
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
    end,
}
