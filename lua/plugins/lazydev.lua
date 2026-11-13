return {
    src = 'folke/lazydev.nvim',
    config = function()
        require('lazydev').setup({
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                -- Load snacks.nvim types
                { path = 'snacks.nvim',        words = { 'Snacks' } },
            },
        })
    end,
}
