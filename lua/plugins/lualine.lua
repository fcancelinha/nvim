return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local C = require('nordern.colors')

        local custom_nordern = require('lualine.themes.nordern')
        custom_nordern.normal.x.bg = C.none
        custom_nordern.insert.x.bg = C.none
        custom_nordern.visual.x.bg = C.none
        custom_nordern.replace.x.bg = C.none
        custom_nordern.command.x.bg = C.none
        custom_nordern.normal.b.bg = C.none
        custom_nordern.insert.b.bg = C.none
        custom_nordern.visual.b.bg = C.none
        custom_nordern.replace.b.bg = C.none
        custom_nordern.command.b.bg = C.none
        custom_nordern.normal.c.bg = C.none
        custom_nordern.insert.c.bg = C.none
        custom_nordern.visual.c.bg = C.none
        custom_nordern.replace.c.bg = C.none
        custom_nordern.command.c.bg = C.none

        require('lualine').setup({
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = custom_nordern,
                component_separators = {},
                section_separators = {},
                ignore_focus = {},
                always_divide_middle = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
                disabled_filetypes = {
                    statuslines = {},
                    winbar = {},
                    'alpha',
                    'lazygit',
                },
            },
            sections = {
                lualine_a = {
                    {
                        'searchcount',
                        icon = { '', color = { fg = C.bg }, align = 'left' },
                        color = { fg = C.bg },
                    },
                    {
                        'selectioncount',
                        icon = { '󰒅', color = { fg = C.bg }, align = 'left' },
                        color = { fg = C.bg },
                    },
                },
                lualine_b = {
                    {
                        'branch',
                        icon = { '󰊢', color = { fg = C.aurora.green, bg = C.none }, align = 'left' },
                        color = { fg = C.snow.c2, bg = C.none },
                        left_padding = 2,
                    },
                    {
                        'diff',
                        color = { bg = C.bg },
                    },
                    {
                        'filetype',
                        icon_only = true,
                        padding = { left = 1, right = 0 },
                    },
                    {
                        'filename',
                        file_status = true,
                        newfile_status = true,
                        padding = { left = 0, right = 1 },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'hint' },
                        diagnostics_color = {
                            hint = {
                                bg = C.blend.turquoise,
                                fg = C.frost.turquoise,
                            }
                        },
                        update_in_insert = true,
                        symbols = { hint = ' ' },
                        padding = 1,
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'info' },
                        diagnostics_color = {
                            info = {
                                bg = C.blend.bluec1,
                                fg = C.frost.turquoise,
                            }
                        },
                        update_in_insert = true,
                        symbols = { info = ' ' },
                        padding = 1,
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'warn' },
                        diagnostics_color = {
                            warn = {
                                bg = C.blend.yellow,
                                fg = C.aurora.yellow,
                            }
                        },
                        update_in_insert = true,
                        symbols = { warn = ' ' },
                        padding = 1,
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'error' },
                        diagnostics_color = {
                            error = {
                                bg = C.blend.red,
                                fg = C.aurora.red,
                            }
                        },
                        update_in_insert = true,
                        symbols = { error = '✸ ' },
                        padding = 1,
                    },
                },
                lualine_c = {
                },
                lualine_x = {
                    { 'fileformat' },
                    { 'encoding' },
                    {
                        'lsp_status',
                        icon = { '󰒋', color = { fg = C.aurora.green, bg = C.none }, align = 'left' },
                        color = { fg = C.snow.c2, gui = 'bold' },
                        separator = '|'
                    }
                },
                lualine_y = {},
                lualine_z = {
                    { 'location' },
                    { 'mode' },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' }
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {
                'mason',
                'neo-tree',
                'nvim-dap-ui',
                'quickfix',
                'symbols-outline',
                'trouble',
                'lazy'
            },
        })
    end
}
