return {
    'mason-org/mason.nvim',
    lazy = false,  -- Load immediately for DAP setup
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
        vim.env.PATH = table.concat({ vim.fn.stdpath('data'), 'mason', 'bin' }, '/') .. ':' .. vim.env.PATH
        require('mason').setup({
            ui = {
                border = 'rounded',
                width = 0.5,
            }
        })

        -- Load server configurations to determine which servers to install
        local servers_path = vim.fn.stdpath('config') .. '/lua/lsp/'
        local server_files = vim.fn.globpath(servers_path, '*.lua', false, true)

        local server_configs = {}
        for _, file_path in ipairs(server_files) do
            local filename = vim.fn.fnamemodify(file_path, ':t:r')
            server_configs[filename] = true  -- Just mark as configured
        end

        -- Manual servers
        local manual_servers = {
            'bashls',
            'dockerls',
            'golangci_lint_ls',
            'eslint',
        }

        require('mason-lspconfig').setup({
            ensure_installed = vim.list_extend(vim.tbl_keys(server_configs), manual_servers),
        })

        require('mason-nvim-dap').setup({
            ensure_installed = { 'delve' }, -- Go debugger
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
            },
        })
    end
}
