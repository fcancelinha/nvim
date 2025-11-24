return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies =
    {
        'olimorris/persisted.nvim',
        event = 'BufReadPre',
        lazy = false,
        config = function()
            require('persisted').setup()
        end
    },
    opts = {
        picker = {
            sources = {
                explorer = {
                    hidden = true,
                    exclude = { '.git' },
                    include = { '.env' },
                    auto_close = false,
                    follow_file = false,
                    jump = {
                        close = false
                    },
                    layout = {
                        layout = {
                            position = 'left'
                        }
                    }
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
            width = 5,
            sections = {
                -- hidden
                { hidden = true, icon = { ' ', hl = 'error' }, key = 'n', desc = { 'new file' }, action = ':ene | startinsert' },
                { hidden = true, icon = { ' ', hl = 'constant' }, key = 'r', desc = { 'recent files' }, action = ':Telescope oldfiles' },
                { hidden = true, icon = { ' ', hl = 'constant' }, key = 't', desc = { 'find text' }, action = ':Telescope live_grep' },
                { hidden = true, icon = { ' ', hl = 'number' }, key = 'e', desc = { 'restore session' }, action = ':SessionLoadLast' },
                { hidden = true, icon = { '󰏗 ', hl = 'specialchar' }, key = 'l', desc = { 'lazy' }, action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                -- header
                {
                    padding = 1,
                    text = {
                        { 'Neovim :: b l λ m e ', hl = 'function' },
                        { '- base reality', hl = 'nontext' },
                        { ' ', width = 2 },
                    },
                    align = 'center',
                },
                -- keys
                {
                    padding = 0.7,
                    text = {
                        { '  [f]ind file', width = 20, hl = 'nontext' },
                        { '  find [t]ext', hl = 'nontext' },
                    },
                    action = ':Telescope find_files',
                    key = 'f',
                    align = 'center',
                },
                {
                    padding = 0.7,
                    text = {
                        { ' ', width = 3 },
                        { '  [n]ew file', width = 20, hl = 'nontext' },
                        { '  [r]ecent files', hl = 'nontext' },
                    },
                    action = ':ene | startinsert',
                    key = 'n',
                    align = 'center',
                },
                {
                    padding = 0.7,
                    text = {
                        { ' ', width = 7 },
                        { '󰐮  [p]rojects', width = 20, hl = 'nontext' },
                        { '󰦛  r[e]store session', hl = 'nontext' },
                    },
                    action = function() Snacks.picker.projects() end,
                    key = 'p',
                    align = 'center',
                },
                {
                    padding = 0.7,
                    text = {
                        { ' ', width = 9 },
                        { '  [c]onfig', hl = 'nontext' },
                        { ' ', width = 9 },
                        { '󰏗  [l]azy', hl = 'nontext' },
                        { ' ', width = 14 },
                    },
                    -- action = ':Telescope find_files cwd=' .. vim.fn.stdpath('config'),
                    action = function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end,
                    key = 'c',
                    align = 'center',
                },
                {
                    padding = 1,
                    text = {
                        { '  [q]uit', hl = 'nontext' },
                    },
                    action = ':quitall',
                    key = 'q',
                    align = 'center',
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
        },
    },
    keys = {
        -- Existing Keys
        { '<leader>gg', function() require('snacks').lazygit() end,         desc = 'Toggle lazygit' },
        { '<C-\\>',     function() require('snacks').terminal() end,        desc = 'Toggle terminal' },
        { '\\',         function() require('snacks').explorer() end,        desc = 'Toggle explorer' },
        -- Picker keys (converted from Telescope)
        { '<leader>fD', function() Snacks.picker.diagnostics() end,         desc = 'Snacks diagnostics' },
        { '<leader>fb', function() Snacks.picker.buffers() end,             desc = 'Snacks buffers' },
        { '<leader>ff', function() Snacks.picker.smart() end,               desc = 'Snacks find files' },
        { '<leader>fj', function() Snacks.picker.grep() end,                desc = 'Snacks live grep' },
        { '<leader>fk', function() Snacks.picker.grep_word() end,           desc = 'Snacks grep string' },
        { '<leader>fl', function() Snacks.picker.recent() end,              desc = 'Snacks old files' },
        { '<leader>fm', function() Snacks.picker.marks() end,               desc = 'Snacks marks' },
        -- Git
        { '<leader>fg', function() Snacks.picker.git_files() end,           desc = 'Snacks git files' },
        { '<leader>fB', function() Snacks.picker.git_branches() end,        desc = 'Snacks git branches' },
        { '<leader>fc', function() Snacks.picker.git_log() end,             desc = 'Snacks git commits' },
        -- Lsp
        { '<leader>fd', function() Snacks.picker.lsp_definitions() end,     desc = 'Snacks definitions' },
        { '<leader>fi', function() Snacks.picker.lsp_incoming_calls() end,  desc = 'Snacks incoming calls' },
        { '<leader>fo', function() Snacks.picker.lsp_outgoing_calls() end,  desc = 'Snacks outgoing calls' },
        { '<leader>fr', function() Snacks.picker.lsp_references() end,      desc = 'Snacks find references' },
        { '<leader>fs', function() Snacks.picker.lsp_symbols() end,         desc = 'Snacks document symbols' },
        { '<leader>fy', function() Snacks.picker.lsp_implementations() end, desc = 'Snacks lsp implementations' },
        -- Misc
        { '<leader>fp', function() Snacks.picker.projects() end,            desc = 'Snacks lsp implementations' },
        { '<leader>ga', function() Snacks.picker.lsp_code_actions() end,    desc = 'Snacks code actions',       mode = { 'v', 'n' } }
    }
}
