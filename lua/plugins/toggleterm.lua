return {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
        open_mapping = [[<c-t>]],
        autochdir = true,
        shade_terminals = false,
        direction = 'horizontal',
        close_on_exit = true,
        size = 10,
        highlights = {
            Normal = {
                guibg = '#2e3440',
            },
        },
    },
}
