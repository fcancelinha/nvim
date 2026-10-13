return {
    'mason-org/mason.nvim',
    lazy = false, -- Load immediately for DAP setup
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
        -- Add mason bin to PATH
        vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

        require('mason').setup({
            ui = {
                border = 'rounded',
                width = 0.5,
            }
        })

        require('mason-lspconfig').setup({
            -- Only installs binaries. Enabling stays in core/lsp.lua: without
            -- nvim-lspconfig on the runtimepath mason ships no cmd/filetypes for
            -- these servers, so automatic_enable registers names that never attach.
            automatic_enable = false,
            ensure_installed = { 'pyright', 'ruff' },
        })

        require('mason-nvim-dap').setup({
            ensure_installed = { 'delve', 'python' },
            automatic_installation = true,
            handlers = {}, -- Use default handlers
        })

        -- Formatters and other non-LSP, non-DAP tools. Neither mason-lspconfig
        -- nor mason-nvim-dap covers these, so install them off the registry.
        local registry = require('mason-registry')
        registry.refresh(function()
            for _, name in ipairs({ 'goimports', 'gofumpt' }) do
                local ok, pkg = pcall(registry.get_package, name)
                if ok and not pkg:is_installed() then
                    pkg:install()
                end
            end
        end)
    end
}
