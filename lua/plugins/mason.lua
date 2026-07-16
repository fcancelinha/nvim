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
            automatic_installation = true, -- Auto-install servers when entering a buffer
        })

        require('mason-nvim-dap').setup({
            ensure_installed = { 'delve' },
            automatic_installation = true,
            handlers = {}, -- Use default handlers
        })
    end
}
