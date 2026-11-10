local function current_buffer_dir()
    return vim.fn.expand('%:p:h')
end

-- Nearest enclosing project root, Go or Python, falling back to cwd.
local function current_project_root()
    local markers = { 'go.work', 'go.mod', '.git' }
    return vim.fs.root(vim.api.nvim_buf_get_name(0), markers) or vim.fn.getcwd()
end

local neotest_ns = vim.api.nvim_create_namespace('neotest')

vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            return diagnostic.message
                :gsub('\n', ' ')
                :gsub('\t', ' ')
                :gsub('%s+', ' ')
                :gsub('^%s+', '')
        end,
    },
}, neotest_ns)

require('neotest').setup({
    adapters = {
        require('neotest-golang')({
            runner = 'gotestsum',
            go_test_args = {
                '-v',
                '-race',
                '-count=1',
                '-timeout=60s',
                '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out',
            },
            gotestsum_args = { '--format=standard-verbose' },
            testify_enabled = true,
            dap_mode = 'dap-go',
        }),
    },
    concurrent = true,
    floating = {
        border = 'rounded',
        max_height = 0.6,
        max_width = 0.95,
    },
    diagnostics = {
        enabled = true,
        underline = false,
        virtual_text = true,
    },
    summary = {
        enabled = true,
        follow = true,
        expand_errors = true,
        open = 'botright vsplit | vertical resize 80',
    },
    output = {
        enabled = true,
        open_on_run = 'short',
        enter = true,
    },
    output_panel = {
        enabled = true,
        open = 'botright split | resize 20',
    },
})

local keys = {
    { '<leader>tr', function() require('neotest').run.run() end,                                           'Run nearest test' },
    { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,                         'Run file tests' },
    { '<leader>tc', function() require('neotest').run.run(current_buffer_dir()) end,                       'Run package tests' },
    { '<leader>ta', function() require('neotest').run.run(current_project_root()) end,                     'Run all project tests' },
    { '<leader>tn', function() require('neotest').run.run({ strategy = 'dap' }) end,                       'Debug nearest test' },
    { '<leader>td', function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,   'Debug file tests' },
    { '<leader>tC', function() require('neotest').run.run({ current_buffer_dir(), strategy = 'dap' }) end, 'Debug package tests' },
    { '<leader>to', function() require('neotest').output.open({ enter = true }) end,                       'Open test output' },
    { '<leader>tt', function() require('neotest').watch.toggle(vim.fn.expand('%')) end,                    'Toggle watch' },
    { '<leader>tp', function() require('neotest').output_panel.toggle() end,                               'Toggle output panel' },
    { '<leader>ts', function() require('neotest').summary.toggle() end,                                    'Toggle summary' },
    { '<leader>tS', function() require('neotest').run.stop() end,                                          'Stop running tests' },
}

for _, map in ipairs(keys) do
    vim.keymap.set('n', map[1], map[2], { desc = map[3], silent = true })
end
