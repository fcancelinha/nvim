return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies =
    {
        'folke/persistence.nvim',
        event = 'BufReadPre',
        lazy = false,
        opts = {
            dir = vim.fn.stdpath('state') .. '/sessions/',
            need = 0
        }
    },
    opts = {
        picker = {
            sources = {
                explorer = {
                    hidden = true,
                    exclude = { '.git' },
                    include = { '.env' },
                }
            }
        },
        explorer = {
            enabled = true,
        },
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
            sections = {
                -- hidden
                { hidden = true, icon = { ' ', hl = 'error' }, key = 'n', desc = { 'new file' }, action = ':ene | startinsert' },
                { hidden = true, icon = { ' ', hl = 'constant' }, key = 'r', desc = { 'recent files' }, action = ':Telescope oldfiles' },
                { hidden = true, icon = { ' ', hl = 'constant' }, key = 't', desc = { 'find text' }, action = ':Telescope live_grep' },
                { hidden = true, icon = { ' ', hl = 'number' }, key = 'e', desc = { 'restore session' }, section = 'session' },
                { hidden = true, icon = { '󰏗 ', hl = 'specialchar' }, key = 'l', desc = { 'lazy' }, action = ':lazy', enabled = package.loaded.lazy ~= nil },
                -- header
                {
                    padding = 1,
                    text = {
                        { 'neovim :: b l λ m e ', hl = 'function' },
                        { '- base reality', hl = 'nontext' },
                    },
                    align = 'center',
                },
                -- keys
                {
                    padding = 0.7,
                    text = {
                        { '  find [f]ile', width = 19, hl = 'nontext' },
                        { '  find [t]ext', hl = 'nontext' },
                    },
                    action = ':Telescope find_files',
                    key = 'f',
                },
                {
                    padding = 0.7,
                    text = {
                        { ' ', width = 3 },
                        { '  [n]ew file', width = 19, hl = 'nontext' },
                        { '  [r]ecent file', hl = 'nontext' },
                    },
                    action = ':ene | startinsert',
                    key = 'n',
                },
                {
                    padding = 0.7,
                    text = {
                        { ' ', width = 9 },
                        { '  [c]onfig', hl = 'nontext' },
                        { ' ', width = 8 },
                        { '󰏗  [l]azy', hl = 'nontext' },
                        { ' ', width = 14 },
                    },
                    action = ':Telescope find_files cwd=' .. vim.fn.stdpath('config'),
                    key = 'c',
                },
                {
                    padding = 0.7,
                    text = {
                        { ' ', width = 20 },
                        { '󰐮  [p]rojects', hl = 'nontext' },
                        { ' ', width = 6 },
                        { '󰦛  r[e]store session', hl = 'nontext' },
                        { ' ', width = 14 },
                    },
                    action = ":lua snacks.dashboard.pick('projects')",
                    key = 'p',
                },
                {
                    padding = 1,
                    text = {
                        { ' ', width = 5 },
                        { '  [q]uit', hl = 'nontext' },
                    },
                    action = ':quitall',
                    key = 'q',
                },
                -- footer
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
        { '<leader>gg', function() require('snacks').lazygit() end,  desc = 'Toggle lazygit' },
        { '<C-\\>',     function() require('snacks').terminal() end, desc = 'Toggle terminal' },
        { '\\',         function() require('snacks').explorer() end, desc = 'Toggle explorer' },
    }
}
