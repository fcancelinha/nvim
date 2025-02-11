return {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
        provider  = 'copilot',
        windows   = {
            ---@type "right" | "left" | "top" | "bottom"
            position = 'right',   -- the position of the sidebar
            wrap = true,          -- similar to vim.o.wrap
            width = 40,           -- default % based on available width
            sidebar_header = {
                enabled = true,   -- true, false to enable/disable the header
                align = 'center', -- left, center, right for title
                rounded = true,
            },
            input = {
                prefix = '> ',
                height = 8, -- Height of the input window in vertical layout
            },
            edit = {
                border = 'rounded',
                start_insert = true, -- Start insert mode when opening the edit window
            },
            ask = {
                floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = true, -- Start insert mode when opening the ask window
                border = 'rounded',
                ---@type "ours" | "theirs"
                focus_on_apply = 'ours', -- which diff to focus after applying
            },
        },
        behaviour = {
            support_paste_from_clipboard = true,
        },
        hints     = {
            enabled = false,
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        --- The below dependencies are optional,
        'echasnovski/mini.pick',         -- for file_selector provider mini.pick
        'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
        'hrsh7th/nvim-cmp',              -- autocompletion for avante commands and mentions
        'ibhagwan/fzf-lua',              -- for file_selector provider fzf
        'nvim-tree/nvim-web-devicons',   -- or echasnovski/mini.icons
        'zbirenbaum/copilot.lua',        -- for providers='copilot'
        {
            -- support for image pasting
            'HakonHarnes/img-clip.nvim',
            event = 'VeryLazy',
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { 'markdown', 'Avante' },
            },
            ft = { 'markdown', 'Avante' },
        },
    },
}
