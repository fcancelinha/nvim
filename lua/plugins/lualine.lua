return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local lualine_colors = {
            dark           = '#2E3440',
            frostblue      = '#5E81Ac',
            frostgreen     = '#8FBCBB',
            frostlightblue = '#81A1C1',
            frostturquoise = "#88C0D0",
            green          = '#A3BE8C',
            grey           = "#434C5E",
            greydark       = "#3B4252",
            orange         = '#D08770',
            purple         = '#B48EAD',
            red            = '#BF616A',
            snowdark       = '#D8DEE9',
            snowlight      = '#ECEFF4',
            snowshade      = '#E5E9F0',
            yellow         = '#EBCB8B',
            special        = "#384356",
            none           = "None",
        }

        local custom_nordern = require('lualine.themes.nordern')
        custom_nordern.normal.a.bg = lualine_colors.none
        custom_nordern.insert.a.bg = lualine_colors.none
        custom_nordern.visual.a.bg = lualine_colors.none
        custom_nordern.replace.a.bg = lualine_colors.none
        custom_nordern.command.a.bg = lualine_colors.none
        custom_nordern.normal.b.bg = lualine_colors.none
        custom_nordern.insert.b.bg = lualine_colors.none
        custom_nordern.visual.b.bg = lualine_colors.none
        custom_nordern.replace.b.bg = lualine_colors.none
        custom_nordern.command.b.bg = lualine_colors.none
        custom_nordern.normal.c.bg = lualine_colors.none
        custom_nordern.insert.c.bg = lualine_colors.none
        custom_nordern.visual.c.bg = lualine_colors.none
        custom_nordern.replace.c.bg = lualine_colors.none
        custom_nordern.command.c.bg = lualine_colors.none

        local function modified()
            if vim.bo.modified then
                return '[+]'
            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                return '[-]'
            end
            return ''
        end

        require('lualine').setup({
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = custom_nordern,
                component_separators = {},
                section_separators = { left = '', right = '' },
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
                    "alpha",
                    "lazygit",
                    "neo-tree",
                },
            },
            sections = {
                lualine_a = {
                },
                lualine_b = {
                },
                lualine_c = {
                },
                lualine_x = {
                    {
                        'branch',
                        icon = { '󰊢 ', color = { fg = lualine_colors.green, bg = lualine_colors.none }, align = 'left' },
                        color = { fg = lualine_colors.yellow, bg = lualine_colors.none },
                        padding = 1,
                    },
                    {
                        'diff',
                        color = { bg = lualine_colors.dark },
                        padding = 3,
                    },
                },
                lualine_y = {
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'hint' },
                        diagnostics_color = {
                            hint = {
                                fg = lualine_colors.frostturquoise,
                                bg = lualine_colors.greydark,
                            }
                        },
                        update_in_insert = true,
                        symbols = { hint = ' ' },
                        padding = 1,
                        separator = { left = '' },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'info' },
                        diagnostics_color = {
                            hint = {
                                fg = lualine_colors.frostblue,
                                bg = lualine_colors.greydark,
                            }
                        },
                        update_in_insert = true,
                        symbols = { hint = ' ' },
                        padding = 1,
                        separator = { left = '' },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'warn' },
                        diagnostics_color = {
                            warn = {
                                fg = lualine_colors.yellow,
                                bg = lualine_colors.greydark,
                            }
                        },
                        update_in_insert = true,
                        symbols = { warn = ' ' },
                        padding = 1,
                        separator = { left = '' },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'error' },
                        diagnostics_color = {
                            error = {
                                fg = lualine_colors.red,
                                bg = lualine_colors.greydark,
                            }
                        },
                        update_in_insert = true,
                        symbols = { error = ' ' },
                        padding = 1,
                        separator = { left = '' },
                    },
                },
                lualine_z = {
                    {
                        modified,
                        padding = 1,
                    },
                    {
                        'searchcount',
                        icon = { '', color = { fg = lualine_colors.dark }, align = 'left' },
                        color = { fg = lualine_colors.dark },
                    },
                    {
                        'selectioncount',
                        icon = { '󰒅', color = { fg = lualine_colors.dark }, align = 'left' },
                        color = { fg = lualine_colors.dark },
                    },
                    {
                        'mode',
                        separator = { left = '', right = '' },
                    },
                },
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
