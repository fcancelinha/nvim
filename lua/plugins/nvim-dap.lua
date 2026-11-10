local dap = require('dap')

require('dapui').setup()
require('nvim-dap-virtual-text').setup()

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error' })
vim.fn.sign_define('DapBreakpointCondition', { text = '󰯲', texthl = 'Conditional' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'Error' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Keyword' })
vim.fn.sign_define('DapStopped', { text = '󱆭', texthl = 'String' })

-- Assign per-key, not a whole-table replacement: mason-nvim-dap
dap.adapters.go = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
        detached = false
    }
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
}

local keys = {
    { '<leader>db', function() dap.toggle_breakpoint() end,   'toggle dap breakpoint' },
    { '<leader>dc', function() dap.continue() end,            'dap continue' },
    { '<leader>di', function() dap.step_into() end,           'dap step into' },
    { '<leader>do', function() dap.step_over() end,           'dap step over' },
    { '<leader>dO', function() dap.step_out() end,            'dap step out' },
    { '<leader>dr', function() dap.repl.toggle() end,         'dap repl toggle' },
    { '<leader>dl', function() dap.run_last() end,            'dap run last' },
    { '<leader>dt', function() dap.terminate() end,           'dap terminate' },
    { '<leader>du', function() require('dapui').toggle() end, 'dap UI toggle' },
}

for _, map in ipairs(keys) do
    vim.keymap.set('n', map[1], map[2], { desc = map[3], silent = true })
end
