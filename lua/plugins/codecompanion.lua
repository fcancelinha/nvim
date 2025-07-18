return {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('codecompanion').setup({
            chat = {
                adapter = 'copilot',
            },
            inline = {
                adapter = 'copilot',
            }
        })
    end
}
