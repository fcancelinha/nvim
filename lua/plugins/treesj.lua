return {
    'Wansmer/treesj',
    keys = {
        '<space>m',
        '<space>j',
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('treesj').setup()
    end,
}
