local C = require('nordern.colors')

-- Transparent middle sections: only the a/z caps keep their mode colour.
local theme = require('lualine.themes.nordern')

for _, mode in ipairs({ 'normal', 'insert', 'visual', 'replace', 'command' }) do
    for _, section in ipairs({ 'b', 'c', 'x' }) do
        theme[mode][section].bg = C.none
    end
end

-- One badge per severity, each with its own blended background.
local function diagnostic(severity, symbol, fg, bg)
    return {
        'diagnostics',
        sources = { 'nvim_lsp' },
        sections = { severity },
        diagnostics_color = { [severity] = { fg = fg, bg = bg } },
        symbols = { [severity] = symbol },
        update_in_insert = true,
        padding = 1,
    }
end

require('lualine').setup({
    options = {
        globalstatus = true,
        icons_enabled = true,
        theme = theme,
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
            diagnostic('hint', ' ', C.frost.turquoise, C.blend.turquoise),
            diagnostic('info', ' ', C.frost.turquoise, C.blend.bluec1),
            diagnostic('warn', ' ', C.aurora.yellow, C.blend.yellow),
            diagnostic('error', '✸ ', C.aurora.red, C.blend.red),
        },
        lualine_c = {},
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
    },
})
