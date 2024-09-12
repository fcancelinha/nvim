return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        open_mapping = [[<leader>p]], -- or { [[<c-\>]] } if you also use a Japanese keyboard.
        autochdir = true,
        direction = 'horizontal',     --'vertical' | 'horizontal' | 'tab' | 'float',
        highlights = {
            Normal = {
                guibg = "Normal",
            },
        },
    }
}
