return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-plenary",
        -- Your other test adapters here
        "nvim-neotest/neotest-vim-test",
        "fredrikaverpil/neotest-golang", -- Installation
    },
    opts = {
        -- See all config options with :h neotest.Config
        discovery = {
            -- Drastically improve performance in ginormous projects by
            -- only AST-parsing the currently opened buffer.
            enabled = true,
            -- Number of workers to parse files concurrently.
            -- A value of 0 automatically assigns number based on CPU.
            -- Set to 1 if experiencing lag.
            concurrent = 0,
        },
        running = {
            -- Run tests concurrently when an adapter provides multiple commands to run.
            concurrent = true,
        },
        summary = {
            -- Enable/disable animation of icons.
            animated = true,
        },
    },
    config = function()
        -- get neotest namespace (api call creates or returns namespace)
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
                require("neotest-golang")({
                    dap_go_enabled = true,
                }),
            },
        })
    end,
}
