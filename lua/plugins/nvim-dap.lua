return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'antoinemadec/FixCursorHold.nvim',
        'nvim-neotest/nvim-nio',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
        { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'toggle dap breakpoint' },
        { '<leader>dc', function() require('dap').continue() end,          desc = 'dap continue' },
        { '<leader>di', function() require('dap').step_into() end,         desc = 'dap step into' },
        { '<leader>do', function() require('dap').step_over() end,         desc = 'dap step over' },
        { '<leader>dO', function() require('dap').step_out() end,          desc = 'dap step out' },
        { '<leader>dr', function() require('dap').repl.toggle() end,       desc = 'dap repl toggle' },
        { '<leader>dl', function() require('dap').run_last() end,          desc = 'dap run last ' },
        { '<leader>dt', function() require('dap').terminate() end,         desc = 'dap terminate' },
        { '<leader>du', function() require('dapui').toggle() end,          desc = 'dap UI toggle' },
    },
    config = function()
        local dap = require('dap')
        require('dapui').setup()

        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '󰯲', texthl = 'Conditional' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'Error' })
        vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Keyword' })
        vim.fn.sign_define('DapStopped', { text = '󱆭', texthl = 'String' })

        dap.adapters = {
            go = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = 'dlv',
                    args = { 'dap', '-l', '127.0.0.1:${port}' },
                    -- add this if on windows, otherwise server won't open successfully
                    detached = false
                }
            },
        }

        -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
        dap.configurations.go = {
            {
                type = 'go',
                name = 'Debug',
                request = 'launch',
                program = './${relativeFileDirname}'
            },
            {
                type = 'go',
                name = 'Debug test', -- configuration for debugging test files
                request = 'launch',
                mode = 'test',
                program = './${relativeFileDirname}'
            },
            -- works with go.mod packages and sub packages
            {
                type = 'go',
                name = 'Debug test (go.mod)',
                request = 'launch',
                mode = 'test',
                program = './${relativeFileDirname}'
            },
            {
                name = 'Local Mirrord Debug',
                type = 'go',
                request = 'launch',
                program = '${workspaceFolder}/cmd/main.go',
                env = {
                    MIRRORD_CONFIG_FILE = '${workspaceFolder}/.mirrord/mirrord.json', -- Path to mirrord.json
                },
                args = {
                    'run',
                    '.',
                    '--log-level',
                    'debug',
                    '--db-ctx-timeout',
                    '50',
                    '--db-cleanup-timeout',
                    '3000'
                }
            }
        }
    end,
}
