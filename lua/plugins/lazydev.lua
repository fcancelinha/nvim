return {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
        library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            -- Load lazy.nvim types
            { path = 'lazy.nvim', words = { 'lazy' } },
            -- Load snacks.nvim types
            { path = 'snacks.nvim', words = { 'Snacks' } },
        },
    },
}
