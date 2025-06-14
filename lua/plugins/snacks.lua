return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        lazygit = {
            enabled = true,
            theme = {
                activeBorderColor = { fg = 'String', bold = true },
            }
        },
        statuscolumn = {
            enabled = true,
        },
        notifier = {
            enabled = true
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
            width = 18,
            preset = {
                keys = {
                }
            },
            sections = {
                -- Hidden
                { hidden = true, icon = { ' ', hl = 'Error' }, key = 'n', desc = { 'New File' }, action = ':ene | startinsert' },
                { hidden = true, icon = { ' ', hl = 'Constant' }, key = 'r', desc = { 'Recent Files' }, action = ":lua Snacks.dashboard.pick('oldfiles')" },
                { hidden = true, icon = { ' ', hl = 'Number' }, key = 'e', desc = { 'Restore Session' }, section = 'session' },
                { hidden = true, icon = { '󰏗 ', hl = 'SpecialChar' }, key = 'L', desc = { 'Lazy' }, action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                -- Header
                {
                    padding = 1,
                    text = {
                        { 'Neovim :: B L Λ M E ', hl = 'Function' },
                        { '- Base reality', hl = 'NonText' },
                    },
                    align = 'center',
                },
                -- Keys
                {
                    padding = 0.7,
                    text = {
                        { '  Find [F]ile', width = 19, hl = 'NonText' },
                        { '  Find [T]ext', hl = 'NonText' },
                    },
                    action = ":lua Snacks.dashboard.pick('files')",
                    key = 'f',
                },
                {
                    padding = 0.7,
                    text = {
                        { ' ', width = 3 },
                        { '  [N]ew File', width = 19, hl = 'NonText' },
                        { '  [R]ecent File', hl = 'NonText' },
                    },
                    action = ':ene | startinsert',
                    key = 'n',
                },
                {
                    padding = 0.7,
                    text = {
                        { ' ', width = 9 },
                        { '  [C]onfig', hl = 'NonText' },
                        { ' ', width = 8 },
                        { '󰏗  [L]azy', hl = 'NonText' },
                        { ' ', width = 14 },
                    },
                    action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    key = 'c',
                },
                {
                    padding = 1,
                    text = {
                        { ' ', width = 5 },
                        { '  [Q]uit', hl = 'NonText' },
                    },
                    action = ':quitall',
                    key = 'q',
                },
                -- Footer
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
