return {
    src = 'nvim-treesitter/nvim-treesitter',
    config = function()
        require('nvim-treesitter').setup({
            -- Prepended to runtimepath so these parsers and queries win.
            install_dir = vim.fn.stdpath('data') .. '/site',
        })
    end,
}
