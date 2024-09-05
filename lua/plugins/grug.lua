return {
    'MagicDuck/grug-far.nvim',
    config = function()
        require('grug-far').setup({
            keymaps = {
                replace           = { n = '<space>z' },
                qflist            = { n = '<space>q' },
                syncLocations     = { n = '<space>x' },
                syncLine          = { n = '<space>l' },
                close             = { n = '<space>c' },
                historyOpen       = { n = '<space>t' },
                historyAdd        = { n = '<space>a' },
                refresh           = { n = '<space>f' },
                openLocation      = { n = '<space>o' },
                gotoLocation      = { n = '<enter>' },
                pickHistoryEntry  = { n = '<enter>' },
                abort             = { n = '<space>b' },
                help              = { n = 'g?' },
                toggleShowCommand = { n = '<space>p' },
                swapEngine        = { n = '<space>e' },
            },
        })
    end
}
