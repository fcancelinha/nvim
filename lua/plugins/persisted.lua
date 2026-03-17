return {
    'olimorris/persisted.nvim',
    event = 'BufReadPre',
    lazy = false,
    config = function()
        require('persisted').setup()
    end
}