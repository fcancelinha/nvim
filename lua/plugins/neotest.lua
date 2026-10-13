local function current_buffer_dir()
    return vim.fn.expand('%:p:h')
end

-- Nearest enclosing project root, Go or Python, falling back to cwd.
local function current_project_root()
    local markers = { 'go.work', 'go.mod', 'pyproject.toml', 'setup.py', 'setup.cfg', '.git' }
    return vim.fs.root(vim.api.nvim_buf_get_name(0), markers) or vim.fn.getcwd()
end

return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-neotest/neotest-python',
        'nvim-lua/plenary.nvim',           -- still useful / commonly expected
        'antoinemadec/FixCursorHold.nvim', -- recommended by neotest
        {
            'fredrikaverpil/neotest-golang',
            version = '*',
            build = function()
                vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait()
            end,
            -- Prefer the official dap-go integration if you have it
            dependencies = {
                'leoluz/nvim-dap-go',
            },
        },
    },
    keys = {
        { '<leader>tr', function() require('neotest').run.run() end,                                           desc = 'Run nearest test' },
        { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,                         desc = 'Run file tests' },
        { '<leader>tc', function() require('neotest').run.run(current_buffer_dir()) end,                       desc = 'Run package tests' },
        { '<leader>ta', function() require('neotest').run.run(current_project_root()) end,                     desc = 'Run all project tests' },
        { '<leader>tn', function() require('neotest').run.run({ strategy = 'dap' }) end,                       desc = 'Debug nearest test' },
        { '<leader>td', function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,   desc = 'Debug file tests' },
        { '<leader>tC', function() require('neotest').run.run({ current_buffer_dir(), strategy = 'dap' }) end, desc = 'Debug package tests' },
        { '<leader>to', function() require('neotest').output.open({ enter = true }) end,                       desc = 'Open test output' },
        { '<leader>tt', function() require('neotest').watch.toggle(vim.fn.expand('%')) end,                    desc = 'Toggle watch' },
        { '<leader>tp', function() require('neotest').output_panel.toggle() end,                               desc = 'Toggle output panel' },
        { '<leader>ts', function() require('neotest').summary.toggle() end,                                    desc = 'Toggle summary' },
        { '<leader>tS', function() require('neotest').run.stop() end,                                          desc = 'Stop running tests' },
    },
    config = function()
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
                        -- add your common tags if you use them:
                        -- '-tags=integration',
                        '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out',

                    },
                    gotestsum_args = { '--format=standard-verbose' },
                    testify_enabled = true,

                    -- Prefer the official integration when possible
                    dap_mode = 'dap-go', -- instead of "manual"
                    -- If you stay with manual, keep your existing dap_manual_config

                    -- Optional but useful:
                    -- env = { ... },
                    -- sanitize_output = true,   -- if you ever see weird characters
                }),

                require('neotest-python')({
                    runner = 'pytest',
                    args = { '-vv' },
                    -- Step into library code, not just your own frames
                    dap = { justMyCode = false },
                }),
            },

            -- log_level = vim.log.levels.INFO,  -- DEBUG is noisy for daily use
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
    end,
}
