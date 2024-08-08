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
        }

        local custom_northern = require('lualine.themes.northern')

        custom_northern.normal.c.bg = lualine_colors.dark
        custom_northern.insert.c.bg = lualine_colors.dark
        custom_northern.visual.c.bg = lualine_colors.dark
        custom_northern.replace.c.bg = lualine_colors.dark
        custom_northern.command.c.bg = lualine_colors.dark

        local function lsp_server()
            local msg = ''
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return '[' .. client.name .. ']'
                end
            end
            return msg
        end

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
                theme = custom_northern,
                section_separators = {},
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
                    -- {
                    --     'mode',
                    --     separator = {},
                    --     right_padding = 2,
                    --     left_padding = 2,
                    -- },
                    {
                        'branch',
                        icon = { '󰊢 ', color = { bg = lualine_colors.special, fg = lualine_colors.green }, align = 'left' },
                        color = { bg = lualine_colors.special, fg = lualine_colors.yellow },
                        separator = {},
                        padding = 2,
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'hint' },
                        diagnostics_color = { hint = { bg = lualine_colors.frostturquoise, fg = lualine_colors.dark } },
                        update_in_insert = true,
                        symbols = { hint = ' ' },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'warn' },
                        diagnostics_color = { warn = { bg = lualine_colors.yellow, fg = lualine_colors.dark } },
                        update_in_insert = true,
                        symbols = { warn = ' ' },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'error' },
                        diagnostics_color = { error = { bg = lualine_colors.red, fg = lualine_colors.dark } },
                        update_in_insert = true,
                        symbols = { error = ' ' },
                    },
                },
                lualine_b = {
                },
                lualine_c = {
                },
                lualine_x = {
                },
                lualine_y = {
                    {
                        modified,
                        color = { bg = lualine_colors.dark },
                    },
                    {
                        'diff',
                        color = { bg = lualine_colors.dark }
                    },
                    {
                        lsp_server,
                        color = { bg = lualine_colors.dark },
                        icon = { '󰒋', color = { bg = lualine_colors.dark, fg = lualine_colors.frostturquoise }, align = 'left' },
                    },
                    -- {
                    -- 	'filetype',
                    -- 	color = { bg = lualine_colors.dark },
                    -- 	icon_only = false,
                    -- 	icon = { align = 'left' },
                    -- 	colored = true,
                    -- },
                },
                lualine_z = {
                    {
                        'searchcount',
                        icon = { '', color = { fg = lualine_colors.dark }, align = 'left' },
                    },
                    {
                        'selectioncount',
                        icon = { '󰒅', color = { fg = lualine_colors.dark }, align = 'left' },
                    },
                    -- {
                    --     'progress',
                    --     left_padding = 2,
                    -- }
                    {
                        'mode',
                        separator = {},
                        padding = 1,
                    },
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
        })
    end
}
