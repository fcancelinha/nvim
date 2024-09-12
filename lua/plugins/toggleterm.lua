return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        size = 7,
        open_mapping = [[<leader>p]], -- or { [[<c-\>]] } if you also use a Japanese keyboard.
        autochdir = true,
        direction = 'horizontal',     --'vertical' | 'horizontal' | 'tab' | 'float',
        shade_terminals = false,
    }
}
