return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        lazygit = {
            enabled = true,
        },
        statuscolumn = {
            enabled = true,
        },
        terminal = {
            enabled = true,
        },
        rename = {
            enabled = true,
        },
        indent = {
            priority = 1,
            enabled = true,
            char = '│',
            animate = {
                enabled = false,
            },
            scope = {
                char = '│',
            }
        },
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = { ' ', hl = 'Function' }, key = 'f', desc = { 'Find File' }, action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = { ' ', hl = 'Error' }, key = 'n', desc = { 'New File' }, action = ':ene | startinsert' },
                    { icon = { ' ', hl = 'String' }, key = 'g', desc = { 'Find Text' }, action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = { ' ', hl = 'Constant' }, key = 'r', desc = { 'Recent Files' }, action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = { ' ', hl = 'Structure' }, key = 'c', desc = { 'Config' }, action = ':Neotree ~/.config/nvim/lua' },
                    { icon = { ' ', hl = 'Number' }, key = 'e', desc = { 'Restore Session' }, section = 'session' },
                    { icon = { '󰏗 ', hl = 'SpecialChar' }, key = 'L', desc = { 'Lazy' }, action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                    { icon = '', desc = '' },
                    { icon = { ' ', hl = 'Normal' }, key = 'q', desc = { 'Quit' }, action = ':qa' },
                }
            },
            sections = {
                {
                    title = { '-- Recent Files --', hl = 'Function' },
                    padding = 1,
                    align = 'center'
                },
                {
                    section = 'recent_files',
                    gap = 0,
                    padding = 1,
                },
                {
                    title = { string.rep('─', 59), hl = 'Function' },
                    align = 'center'
                },
                {
                    section = 'keys',
                    gap = 0,
                    padding = 0,
                    indent = 2
                },
                {
                    title = { string.rep('─', 59), hl = 'Function' },
                    padding = 0,
                    align = 'center'
                },
                {
                    section = 'startup',
                    align = 'center'
                }
            },
            formats = {
                key = function(item)
                    return { { '[', hl = 'Keyword' }, { item.key, hl = 'Function' }, { ']', hl = 'Keyword' } }
                end,
            },
        }
    },
    keys = {
        { '<leader>gg', function() Snacks.lazygit() end,  desc = 'Lazygit' },
        { '<c-\\>',     function() Snacks.terminal() end, desc = 'Toggle Terminal' },
    }
}
