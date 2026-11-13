return {
    src = 'folke/todo-comments.nvim',
    deps = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('todo-comments').setup({
            keywords = {
                FIX = {
                    icon = ' ', -- icon used for the sign, and in search results
                    color = 'warning', -- can be a hex color, or a named color (see below)
                    alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = ' ', color = 'info' },
                WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
                PERF = { icon = '󰓅 ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
                NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
                TEST = { icon = '󰙨 ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
            },
            gui_style = {
                fg = 'NONE', -- The gui style to use for the fg highlight group.
                bg = 'BOLD', -- The gui style to use for the bg highlight group.
            },
        })
    end,
}
