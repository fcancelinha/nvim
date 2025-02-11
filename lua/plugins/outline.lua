return {
    'hedyhli/outline.nvim',
    keys = {
        { '<leader>o', ':Outline<CR>', { desc = 'Toggle Outline' } },
    },
    config = function()
        require('outline').setup {}
    end,
}
