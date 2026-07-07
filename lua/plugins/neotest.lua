local function current_buffer_dir()
    local path = vim.api.nvim_buf_get_name(0)

    if path == '' then
        return vim.uv.cwd()
    end

    return vim.fs.dirname(path)
end

local function current_go_root()
    local root = vim.fs.root(current_buffer_dir(), { 'go.work', 'go.mod', '.git' })

    return root or vim.uv.cwd()
end

return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        {
            'fredrikaverpil/neotest-golang',
            version = '*',
            build = function()
                vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' }):wait()
            end,
        },
    },
    keys = {
        { '<leader>tr', function() require('neotest').run.run() end,                                           desc = 'run test' },
        { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,                         desc = 'run file tests' },
        { '<leader>tc', function() require('neotest').run.run(current_buffer_dir()) end,                       desc = 'run package tests' },
        { '<leader>ta', function() require('neotest').run.run(current_go_root()) end,                          desc = 'run all project tests' },
        { '<leader>tn', function() require('neotest').run.run({ strategy = 'dap' }) end,                       desc = 'run test with dap' },
        { '<leader>td', function() require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' }) end,   desc = 'run file tests with dap' },
        { '<leader>tC', function() require('neotest').run.run({ current_buffer_dir(), strategy = 'dap' }) end, desc = 'debug package tests' },
        { '<leader>to', function() require('neotest').output.open({ enter = true }) end,                       desc = 'open test output' },
        { '<leader>tt', function() require('neotest').watch.toggle(vim.fn.expand('%')) end,                    desc = 'toggle watch test' },
        { '<leader>tp', function() require('neotest').output_panel.toggle() end,                               desc = 'open test output panel' },
        { '<leader>ts', function() require('neotest').summary.toggle() end,                                    desc = 'open summary test panel' },
    },
    config = function()
        local neotest_ns = vim.api.nvim_create_namespace('neotest')

        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message =
                        diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
                    return message
                end,
            },
        }, neotest_ns)

        require('neotest').setup({
            adapters = {
                require('neotest-golang')({
                    runner = 'gotestsum',
                    go_test_args = { '-v', '-race', '-count=1', '-timeout=60s' },
                    gotestsum_args = { '--format=standard-verbose' },
                    testify_enabled = true,
                    dap_mode = 'manual',
                    dap_manual_config = {
                        type = 'go',
                        name = 'Neotest Go',
                        request = 'launch',
                        mode = 'test',
                        outputMode = 'remote',
                    },
                }),
            },
            log_level = vim.log.levels.DEBUG,
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
