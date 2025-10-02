return {
    'mason-org/mason.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    config = function()
        vim.env.PATH = table.concat({ vim.fn.stdpath('data'), 'mason', 'bin' }, '/') .. ':' .. vim.env.PATH
        require('mason').setup({
            ui = {
                border = 'rounded',
                width = 0.5,
            }
        })
    end
}
