return {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
        require("barbecue").setup({
            attach_navic = false,
            create_autocmd = false,
            show_modified = true,
            show_navic = false,
            theme = {
                -- this highlight is used to override other highlights
                -- you can take advantage of its `bg` and set a background throughout your winbar
                -- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
                normal = { fg = "#E5E9F0", bg = "#2E3440", bold = true, underdotted = true },
            },
        })

        vim.api.nvim_create_autocmd({
            "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
            "BufWinEnter",
            "CursorHold",
            "InsertLeave",
            -- include this if you have set `show_modified` to `true`
            -- "BufModifiedSet",
        }, {
            group = vim.api.nvim_create_augroup("barbecue.updater", {}),
            callback = function()
                require("barbecue.ui").update()
            end
        })
    end
}
