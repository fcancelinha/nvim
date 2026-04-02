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
        -- Automatically detect servers from lsp/ directory
        local servers_path = vim.fn.stdpath('config') .. '/lsp/'
        local server_files = vim.fn.glob(servers_path .. '*.lua', false, true)
        local configured_servers = vim.tbl_map(function(path)
            return vim.fn.fnamemodify(path, ':t:r')
        end, server_files)

        -- Additional servers without custom configs
        local additional_servers = { 'bashls', 'docker_language_server', 'eslint', 'docker_compose_language_service',
            'cssls', 'graphql', 'html', }
        local all_servers = vim.list_extend(configured_servers, additional_servers)

        require('mason-lspconfig').setup({
            ensure_installed = all_servers,
            automatic_installation = true, -- Auto-install servers when entering a buffer
        })

        require('mason-nvim-dap').setup({
            ensure_installed = { 'delve' },
            automatic_installation = true,
            handlers = {}, -- Use default handlers
        })
    end
}
