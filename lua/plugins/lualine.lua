return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local colors = {
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
                theme = require('lualine.themes.nordern'),
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
                        icon = { '󰊢 ', color = { fg = colors.green, bg = colors.none }, align = 'left' },
                        color = { fg = colors.yellow, bg = colors.none },
                        padding = 1,
                    },
                    {
                        'diff',
                        color = { bg = colors.dark },
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
                                fg = colors.frostturquoise,
                                bg = colors.greydark,
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
                                fg = colors.frostblue,
                                bg = colors.greydark,
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
                                fg = colors.yellow,
                                bg = colors.greydark,
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
                                fg = colors.red,
                                bg = colors.greydark,
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
                        color = { fg = colors.dark, bg = colors.none },
                        padding = 1,
                    },
                    {
                        'searchcount',
                        icon = { '', color = { fg = colors.dark }, align = 'left' },
                        color = { fg = colors.dark },
                    },
                    {
                        'selectioncount',
                        icon = { '󰒅', color = { fg = colors.dark }, align = 'left' },
                        color = { fg = colors.dark },
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
