return {
    'kristijanhusak/vim-dadbod-ui',
    lazy = true,
    dependencies = {
        {
            'tpope/vim-dadbod',
            lazy = true,
        },
        {
            'kristijanhusak/vim-dadbod-completion',
            ft = {
                'sql',
                'mysql',
                'plsql',
            },
            lazy = true
        },
    },
    cmd = {
        'DB',
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_winwidth = 50
    end,
}
