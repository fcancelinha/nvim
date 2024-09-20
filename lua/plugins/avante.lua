return {
    "yetone/avante.nvim",
    lazy = false,
    build = "make BUILD_FROM_SOURCE=true",
    dependencies = {
        "stevearc/dressing.nvim",
        "MunifTanjim/nui.nvim",
        {
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
                require("copilot").setup()
            end,
        },
    },
    keys = {
        {
            "<leader>qa",
            function() require("avante.api").ask() end,
            { "n", "v" },
            desc = "Avante: ask",
        },
        {
            "<leader>qr",
            function() require("avante.api").refresh() end,
            { "v" },
            desc = "Avante: refresh",
        },
        {
            "<leader>qr",
            function() require("avante.api").edit() end,
            { "n", "v" },
            desc = "Avante: edit",
        }
    },
    opts = {
        provider = "copilot",
        auto_suggestions_provider = "copilot",
        copilot = {
            endpoint = "https://api.githubcopilot.com",
            model = "gpt-4o-2024-05-13",
            proxy = nil,            -- [protocol://]host[:port] Use this proxy
            allow_insecure = false, -- Allow insecure server connections
            timeout = 30000,        -- Timeout in milliseconds
            temperature = 0,
            max_tokens = 4096,
        },
        hints = {
            enabled = false,
        },
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
        },
        windows = {
            ---@type "right" | "left" | "top" | "bottom"
            position = "right",   -- the position of the sidebar
            wrap = true,          -- similar to vim.o.wrap
            width = 40,           -- default % based on available width
            sidebar_header = {
                align = "center", -- left, center, right for title
                rounded = true,
            },
        },
        mappings = {
            ---@class AvanteConflictMappings
            diff = {
                ours = "co",
                theirs = "ct",
                all_theirs = "ca",
                both = "cb",
                cursor = "cc",
                next = "]x",
                prev = "[x",
            },
            suggestion = {
                accept = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
            jump = {
                next = "]]",
                prev = "[[",
            },
            submit = {
                normal = "<CR>",
                insert = "<CR>",
            },
        },
    },
}
