return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "antoinemadec/FixCursorHold.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        -- adapters
        "leoluz/nvim-dap-go",
    },
    keys = {
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "toggle dap breakpoint" },
        { "<leader>dc", function() require("dap").continue() end , desc = "dap continue"},
        { "<leader>di", function() require("dap").step_into() end , desc = "dap step into"},
        { "<leader>do", function() require("dap").step_over() end , desc = "dap step over"},
        { "<leader>dO", function() require("dap").step_out() end , desc = "dap step out"},
        { "<leader>dr", function() require("dap").repl.toggle() end , desc = "dap repl toggle"},
        { "<leader>dl", function() require("dap").run_last() end , desc = "dap run last "},
        { "<leader>dt", function() require("dap").terminate() end , desc = "dap terminate"},
        { "<leader>du", function() require("dapui").toggle() end , desc = "dap UI toggle"},
    },
    config = function()
        require("dapui").setup()

        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '󰯲', texthl = 'Conditional' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'Todo' })
        vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Exception' })
        vim.fn.sign_define('DapStopped', { text = '󱆭', texthl = 'String' })
    end,
}
