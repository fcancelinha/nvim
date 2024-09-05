return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-go",
    },
    config = function()
        local neotest_ns = vim.api.nvim_create_namespace("neotest")

        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message =
                        diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                    return message
                end,
            },
        }, neotest_ns)

        require("neotest").setup({
            adapters = {
                require("neotest-go")({
                    -- args = { "-v", "--race", "--cover" },
                    -- env = { GO111MODULE = "on" },
                    verbose = true,
                    parallel = true,
                    parallel_test = 5,
                    experimental = {
                        test_table = true,
                        test_command = function(position)
                            return "richgo test " .. position
                        end,
                    },
                    coverage = {
                        enabled = true,    -- Enable coverage
                        threshold = 65,    -- Set coverage threshold percentage
                        report_file = nil, -- "coverage.out", -- Coverage output file
                    },
                    recursive_run = true,
                }),
            },
            log_level = vim.log.levels.DEBUG,
            concurrent = true,
            floating = {
                border = "rounded", -- Border style for floating windows
                max_height = 0.5,   -- Max height of the floating window
                max_width = 0.9,    -- Max width of the floating window
            },
            diagnostics = {
                enabled = true,      -- Enable diagnostics integration
                underline = false,   -- Underline diagnostic errors
                virtual_text = true, -- Display virtual text for diagnostics
            },
            summary = {
                enabled = true,       -- Enable summary window
                follow = true,        -- Follow the current test in the summary window
                expand_errors = true, -- Expand errors by default
            },
            output = {
                enabled = true,
                open_on_run = "short", -- Open the output window after test run
                enter = true,          -- Automatically enter the output window
            },
        })
    end,
}
