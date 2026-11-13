return {
    src = 'serhez/bento.nvim',
    config = function()
        require('bento').setup({
            main_keymap = ';',
        })
    end,
}
