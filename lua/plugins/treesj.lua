-- <space>m toggles split/join, <space>j joins, <space>s splits.
return {
    src = 'Wansmer/treesj',
    config = function()
        require('treesj').setup()
    end,
}
