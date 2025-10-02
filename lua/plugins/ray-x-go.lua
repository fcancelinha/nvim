return {
    'ray-x/go.nvim',
    dependencies = {
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {
        tag_transform = 'snakecase',
        lsp_keymaps = false,
        lsp_inlay_hints = {
            enable = false
        },
        trouble = true,
    },
    config = function(lp, opts)
        require('go').setup(opts)
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()'
}
