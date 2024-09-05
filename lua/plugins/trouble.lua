return {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
        {
            "<leader>xd",
            ":Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xD",
            ":Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>xq",
            ":Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "<leader>xl",
            ":Trouble loclist toggle<cr>",
            desc = "Quickfix Loclist (Trouble)",
        },
    },
}
