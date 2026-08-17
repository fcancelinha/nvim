return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'folke/persistence.nvim',
            event = 'BufReadPre', -- this will only start session saving when an actual file was opened
            opts = {
                dir = vim.fn.stdpath('state') .. '/sessions/'
            }
        }
    },
    opts = {
        picker = {
            input = {
                keys = {
                    ['<C-j>'] = { 'list_down', mode = { 'i', 'n' } },
                    ['<C-k>'] = { 'list_up', mode = { 'i', 'n' } },
                }
            },
            layout = {
                backdrop = 'false',
                width = 0.2,
                -- max_width = 70,
                border = 'rounded',
                title = '{title} {live} {flags}',
                title_pos = 'center',
            },
            sources = {
                explorer            = {
                    hidden = true,
                    cwd = vim.uv.cwd(),
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
                },
                files               = {
                    exclude = {
                        -- Go specific
                        'vendor',
                        '**/vendor/**',
                        'pkg/mod',
                        '**/pkg/mod/**',
                        'go/pkg/mod',
                        '**/go/pkg/mod/**',

                        -- general
                        '.git',
                        'node_modules',
                        'dist',
                        'build',
                        'target',
                        '.idea',
                        '.vscode',
                    },
                },
                grep                = {
                    exclude = {
                        'vendor',
                        '**/vendor/**',
                        'pkg/mod',
                        '**/pkg/mod/**',
                        'go/pkg/mod',
                        '**/go/pkg/mod/**',
                        '.git',
                        'node_modules',
                        'dist',
                        'build',
                        'target',
                    },
                },
                grep_word           = {
                    exclude = {
                        'vendor',
                        '**/vendor/**',
                        'pkg/mod',
                        '**/pkg/mod/**',
                        'go/pkg/mod',
                        '**/go/pkg/mod/**',
                        '.git',
                        'node_modules',
                    },
                },
                smart               = {
                    layout = {
                        preset = 'vertical',
                    },
                },
                buffers             = {
                    layout = {
                        preset = 'vertical',
                    },
                },
                diagnostics         = {
                    layout = {
                        preset = 'vertical',
                    },
                },
                lsp_definitions     = {
                    layout = {
                        preset = 'vertical',
                    },
                },
                lsp_incoming_calls  = {
                    layout = {
                        preset = 'vertical',
                    },
                },
                lsp_outgoing_calls  = {
                    layout = {
                        preset = 'vertical',
                    },
                },
                lsp_references      = {
                    layout = {
                        preset = 'vertical',
                    },
                },
                lsp_implementations = {
                    layout = {
                        preset = 'vertical',
                    },
                },
                projects            = {
                    layout = {
                        preset = 'vertical',
                    },
                },
            }
        },
        explorer = {
            enabled = false,
        },
        smoothscroll = {
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
        gh = {
            enabled = true,
        },
        git = {
            enabled = false,
            width = 0.6,
            height = 0.6,
            border = true,
            title = ' Git Blame ',
            title_pos = 'center',
            ft = 'git',
        },
        indent = {
            priority = 1,
            enabled = true,
            char = '│',
            animate = {
                enabled = false,
            },
            scope = {
                enabled = false,
                char = '│',
            }
        },
        dashboard = {
            enabled = true,
            width = 5,
            sections = {
                -- hidden
                { hidden = true, icon = { ' ', hl = 'error' }, key = 'n', desc = { 'new file' }, action = ':ene | startinsert' },
                {
                    hidden = true,
                    icon = { ' ', hl = 'constant' },
                    key = 'r',
                    desc = { 'recent files' },
                    action = function()
                        Snacks.picker.recent()
                    end
                },
                {
                    hidden = true,
                    icon = { ' ', hl = 'constant' },
                    key = 't',
                    desc = { 'find text' },
                    action = function()
                        Snacks.picker.grep()
                    end
                },
                {
                    hidden = true,
                    icon = { ' ', hl = 'number' },
                    key = 'e',
                    desc = { 'restore session' },
                    action = function()
                        require('persistence').load({ last = true })
                    end
                },
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
                    action = function()
                        Snacks.picker.smart()
                    end,
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
                    action = function()
                        Snacks.picker.projects()
                    end,
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
                    action = function()
                        require('neo-tree.command').execute({ dir = vim.fn.stdpath('config') })
                    end,
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
                },
                {
                    text = {
                        {
                            string.format('v%d.%d.%d', vim.version().major, vim.version().minor,
                                vim.version().patch),
                            hl = 'Comment'
                        },
                    },
                    padding = 2,
                    align = 'center',
                },
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
        { '<leader>gg', function() require('snacks').lazygit() end,               desc = 'Toggle lazygit' },
        { '<C-\\>',     function() require('snacks').terminal() end,              desc = 'Toggle terminal' },
        -- { '\\',         function() require('snacks').explorer() end,        desc = 'Toggle explorer' },
        -- Git
        { '<leader>fg', function() Snacks.picker.git_files() end,                 desc = 'Snacks git files' },
        { '<leader>fB', function() Snacks.picker.git_branches() end,              desc = 'Snacks git branches' },
        { '<leader>fc', function() Snacks.picker.git_log() end,                   desc = 'Snacks git commits' },
        -- Github PR's
        { '<leader>gi', function() Snacks.picker.gh_issue() end,                  desc = 'GitHub Issues (open)' },
        { '<leader>gI', function() Snacks.picker.gh_issue({ state = 'all' }) end, desc = 'GitHub Issues (all)' },
        { '<leader>gp', function() Snacks.picker.gh_pr() end,                     desc = 'GitHub Pull Requests (open)' },
        { '<leader>gP', function() Snacks.picker.gh_pr({ state = 'all' }) end,    desc = 'GitHub Pull Requests (all)' },
        -- Picker keys
        { '<leader>fD', function() Snacks.picker.diagnostics() end,               desc = 'Snacks diagnostics' },
        { '<leader>fb', function() Snacks.picker.buffers() end,                   desc = 'Snacks buffers' },
        { '<leader>ff', function() Snacks.picker.smart() end,                     desc = 'Snacks find files' },
        { '<leader>fj', function() Snacks.picker.grep() end,                      desc = 'Snacks live grep' },
        { '<leader>fk', function() Snacks.picker.grep_word() end,                 desc = 'Snacks grep string' },
        { '<leader>fl', function() Snacks.picker.recent() end,                    desc = 'Snacks old files' },
        { '<leader>fm', function() Snacks.picker.marks() end,                     desc = 'Snacks marks' },
        -- Lsp
        { '<leader>fd', function() Snacks.picker.lsp_definitions() end,           desc = 'Snacks definitions' },
        { '<leader>fi', function() Snacks.picker.lsp_incoming_calls() end,        desc = 'Snacks incoming calls' },
        { '<leader>fo', function() Snacks.picker.lsp_outgoing_calls() end,        desc = 'Snacks outgoing calls' },
        { '<leader>fr', function() Snacks.picker.lsp_references() end,            desc = 'Snacks find references' },
        { '<leader>fs', function() Snacks.picker.lsp_symbols() end,               desc = 'Snacks document symbols' },
        { '<leader>fy', function() Snacks.picker.lsp_implementations() end,       desc = 'Snacks lsp implementations' },
        -- Misc
        { '<leader>fp', function() Snacks.picker.projects() end,                  desc = 'Snacks lsp implementations' },
    }
}
