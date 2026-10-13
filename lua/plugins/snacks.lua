-- Nerd-font glyphs are not all the same display width, so anything that needs
-- to line up in a column is padded with `nvim_strwidth`, not `#`.
local function pad(s, width)
    return s .. (' '):rep(math.max(0, width - vim.api.nvim_strwidth(s)))
end

-- Recent files as a compact block. Every row is padded to the same display
-- width so `align = 'center'` centers the list as one unit (left edges lined
-- up) instead of centering each row on its own length.
local function recent_files(limit)
    return function()
        local rows, lens, width = {}, {}, 0
        for i, item in ipairs(Snacks.dashboard.sections.recent_files({ limit = limit })()) do
            local path = vim.fn.fnamemodify(item.file, ':~')
            local dir, name = path:match('^(.*/)([^/]+)$')
            dir, name = dir or '', name or path
            if vim.api.nvim_strwidth(name .. dir) > 44 then
                dir = vim.fn.pathshorten(dir)
            end
            local icon, icon_hl = Snacks.util.icon(name, 'file')
            local text = {
                { pad(tostring(i), 3),     hl = 'nontext' },
                { pad(icon or ' ', 3),     hl = icon_hl or 'icon' },
                { name,                    hl = 'Normal' },
                { '  ' .. dir,             hl = 'Comment' },
            }
            local len = 0
            for _, t in ipairs(text) do
                len = len + vim.api.nvim_strwidth(t[1])
            end
            width, lens[i] = math.max(width, len), len
            rows[i] = { key = tostring(i), action = item.action, align = 'center', text = text }
        end
        for i, row in ipairs(rows) do
            table.insert(row.text, { (' '):rep(width - lens[i]) })
        end
        if rows[#rows] then
            rows[#rows].padding = 1
        end
        return rows
    end
end

-- Two-column key grid. Column widths are measured from the labels themselves so
-- both columns line up, and since every row then has the same total width,
-- `align = 'center'` centers the grid as one block. A row with no second label
-- is centered across the full grid instead.
local GRID_GAP = 4

local function keygrid(rows)
    return function()
        local lw, rw = 0, 0
        for _, row in ipairs(rows) do
            lw = math.max(lw, vim.api.nvim_strwidth(row[3]))
            rw = math.max(rw, row[4] and vim.api.nvim_strwidth(row[4]) or 0)
        end
        lw = lw + GRID_GAP
        local out = vim.tbl_map(function(row)
            local key, action, left, right = unpack(row, 1, 4)
            local text = right
                and { { pad(left, lw), hl = 'nontext' }, { pad(right, rw), hl = 'nontext' } }
                or { { left, width = lw + rw, align = 'center', hl = 'nontext' } }
            return { key = key, action = action, align = 'center', text = text }
        end, rows)
        -- Rows sit flush against each other; only the block gets a trailing gap.
        if out[#out] then
            out[#out].padding = 1
        end
        return out
    end
end

-- Header. `align = 'center'` centers the whole line, which would leave the
-- title itself sitting left of centre once the suffix is appended. A leading
-- spacer as wide as the suffix cancels that out, so the title is centered and
-- the suffix hangs off to its right.
local function header(title, suffix)
    return {
        padding = 1,
        align = 'center',
        text = {
            -- { (' '):rep(vim.api.nvim_strwidth(suffix)) },
            { title,                                   hl = 'function' },
            { suffix,                                  hl = 'nontext' },
        },
    }
end

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
            width = 56,
            sections = {
                -- hidden: keys owned by the right-hand column of the grid
                {
                    hidden = true,
                    key = 't',
                    action = function()
                        Snacks.picker.grep()
                    end
                },
                {
                    hidden = true,
                    key = 'r',
                    action = function()
                        Snacks.picker.recent()
                    end
                },
                {
                    hidden = true,
                    key = 'e',
                    action = function()
                        require('persistence').load({ last = true })
                    end
                },
                { hidden = true, key = 'l', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                -- header
                header('Neovim :: b l λ m e', ' - base reality'),
                -- keys
                keygrid({
                    { 'f', function() Snacks.picker.smart() end, '  [f]ind file',    '  find [t]ext' },
                    { 'n', ':ene | startinsert',                 '  [n]ew file',     '  [r]ecent files' },
                    { 'p', function() Snacks.picker.projects() end, '󰐮  [p]rojects',  '󰦛  r[e]store session' },
                    {
                        'c',
                        function() require('neo-tree.command').execute({ dir = vim.fn.stdpath('config') }) end,
                        '  [c]onfig',
                        '󰏗  [l]azy',
                    },
                    { 'q', ':quitall', '  [q]uit' },
                }),
                -- recent files
                {
                    padding = 1,
                    align = 'center',
                    text = { { '── recent ──', hl = 'nontext' } },
                },
                recent_files(5),
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
                    padding = 1,
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
