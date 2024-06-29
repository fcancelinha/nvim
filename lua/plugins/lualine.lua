return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "Isrothy/lualine-diagnostic-message",
    },
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
        }

        local custom_northern = require('lualine.themes.northern')

        custom_northern.normal.c.bg = colors.dark
        custom_northern.insert.c.bg = colors.dark
        custom_northern.visual.c.bg = colors.dark
        custom_northern.replace.c.bg = colors.dark
        custom_northern.command.c.bg = colors.dark

        local function lsp_server()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                end
            end
            return msg
        end

        require('lualine').setup {
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = custom_northern,
                section_separators = { left = '', right = '' },
                component_separators = "",
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
                },
            },
            sections = {
                lualine_a =
                {
                    {
                        'mode',
                        separator = { left = '', right = '' },
                        right_padding = 2,
                    },
                    -- {
                    --     'filename',
                    --     -- icon = { ' ', color = { bg = colors.grey, fg = colors.green }, align = 'left' },
                    --     color = { bg = colors.special, fg = colors.snowdark },
                    --     -- separator = { left = '', right = '' },
                    --     file_status = true,
                    --     newfile_status = true,
                    --     path = 0,
                    --     shorting_target = 150,
                    -- },
                    {
                        'branch',
                        icon = { '󰊢 ', color = { bg = colors.special, fg = colors.green }, align = 'left' },
                        color = { bg = colors.special, fg = colors.yellow },
                        separator = { left = '', right = '' },
                    },
                },
                lualine_b = {
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'info' },
                        diagnostics_color = { hint = { bg = colors.frostturquoise, fg = colors.dark } },
                        left = '', right = '',
                        update_in_insert = true,
                        symbols = { info = ' ' },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'warn' },
                        diagnostics_color = { warn = { bg = colors.yellow, fg = colors.dark } },
                        left = '', right = '',
                        update_in_insert = true,
                        symbols = { warn = ' ' },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'error' },
                        diagnostics_color = { error = { bg = colors.red, fg = colors.dark } },
                        left = '', right = '',
                        update_in_insert = true,
                        symbols = { error = ' ' },
                    },
                },
                lualine_c = {
                    {
                        'diagnostic-message',
                        colors = {
                            error = colors.red,
                            warn = colors.yellow,
                            info = colors.frostturquoise,
                            hint = colors.frostturquoise,
                        },
                        icons = {
                            error = "",
                            warn = "",
                            info = "",
                            hint = "",
                        },
                    }
                },
                lualine_x = {
                    {
                        'diff',
                        color = { bg = colors.dark }
                    },
                },
                lualine_y = {
                    {
                        'filetype',
                        color = { bg = colors.dark },
                        icon_only = false,
                        icon = { align = 'left' },
                        colored = true,
                    },
                },
                lualine_z = {
                    {
                        'searchcount',
                        icon = { '', color = { fg = colors.dark }, align = 'left' },
                    },
                    {
                        'selectioncount',
                        icon = { '󰒅', color = { fg = colors.dark }, align = 'left' },
                    },
                    {
                        'progress',
                        separator = { left = '', right = '' },
                        left_padding = 2,
                    }
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
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
            },
        }
    end
}
