return {
    src = { 'saghen/blink.cmp', version = vim.version.range('1') },
    deps = {
        'rafamadriz/friendly-snippets',
    },
    config = function()
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        require('blink.cmp').setup({
            keymap = {
                -- All presets have the following mappings:
                -- C-space: Open menu or open docs if already open
                -- C-n/C-p or Up/Down: Select next/previous item
                -- C-e: Hide menu
                -- <Tab> comes from the preset: accept the selection, else advance a
                -- snippet, else fall through.
                preset = 'super-tab',
                -- Map Ctrl+J/K to next/previous completion item
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                -- C-k is taken by select_prev, so signature toggles on C-s
                ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },
            signature = {
                enabled = true,
                window = {
                    border = 'rounded',
                    show_documentation = true,
                },
            },
            appearance = {
                -- 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                nerd_font_variant = 'normal'
            },
            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
                documentation = {
                    auto_show = true,
                    window = {
                        border = 'rounded'
                    },
                },
                menu = {
                    border = 'rounded',
                    draw = {
                        columns = {
                            { 'kind_icon', gap = 3 },
                            { 'label',     'label_description' },
                            { 'kind' },
                        }
                    }
                }
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            -- Rust fuzzy matcher for typo resistance and significantly better
            -- performance, with a Lua fallback when the binary is unavailable.
            fuzzy = { implementation = 'prefer_rust_with_warning' }
        })
    end,
}
