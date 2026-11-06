-- Incline replaces lualine: one fill-width bar per window, file identity on
-- the left and the state lualine used to carry on the right.
local devicons = require 'nvim-web-devicons'

-- Icons carry their own trailing separator, so a glyph that needs breathing
-- room asks for it here rather than in the formatting below.
local ICONS = {
    branch    = '󰊢 ',
    lsp       = '󰒋 ',
    search    = ' ',
    selection = '󰒅 ',
}

local DIFF = {
    { key = 'added',   icon = '+', group = 'InclineDiffAdd' },
    { key = 'changed', icon = '~', group = 'InclineDiffChange' },
    { key = 'removed', icon = '-', group = 'InclineDiffDelete' },
}

local DIAGNOSTICS = {
    { severity = 'ERROR', icon = '✸ ', group = 'InclineDiagnosticError' },
    { severity = 'WARN', icon = ' ', group = 'InclineDiagnosticWarn' },
    { severity = 'INFO', icon = ' ', group = 'InclineDiagnosticInfo' },
    { severity = 'HINT', icon = ' ', group = 'InclineDiagnosticHint' },
}

local MODES = {
    n = { 'N', 'InclineModeNormal' },
    no = { 'O-P', 'InclineModeNormal' },
    v = { 'V', 'InclineModeVisual' },
    V = { 'V-L', 'InclineModeVisual' },
    ['\22'] = { 'V-B', 'InclineModeVisual' },
    s = { 'S', 'InclineModeVisual' },
    S = { 'S-L', 'InclineModeVisual' },
    ['\19'] = { 'S-B', 'InclineModeVisual' },
    i = { 'I', 'InclineModeInsert' },
    R = { 'R', 'InclineModeReplace' },
    Rv = { 'V-R', 'InclineModeReplace' },
    c = { 'C', 'InclineModeCommand' },
    cv = { 'EX', 'InclineModeCommand' },
    r = { 'P', 'InclineModeCommand' },
    rm = { 'M', 'InclineModeCommand' },
    ['r?'] = { '?', 'InclineModeCommand' },
    ['!'] = { '!', 'InclineModeCommand' },
    t = { 'T', 'InclineModeTerminal' },
}

-- A part is { text, group = highlight }. Every component returns a list of
-- them, empty when it has nothing worth showing.
local function badge(text, group)
    return { { text .. ' ', group = group } }
end

-- nvim_strwidth, not strdisplaywidth: it is what incline measures the float
-- with, and the two disagree by a column on strings ending in whitespace.
local function width(parts)
    local n = 0
    for _, p in ipairs(parts) do
        n = n + vim.api.nvim_strwidth(p[1])
    end
    return n
end

local function visual_range()
    local lines = math.abs(vim.fn.line('v') - vim.fn.line('.')) + 1
    local cols = math.abs(vim.fn.col('v') - vim.fn.col('.')) + 1
    local mode = vim.fn.mode()
    if mode == 'V' then
        return tostring(lines)
    elseif mode == '\22' then
        return ('%dx%d'):format(lines, cols)
    end
    return tostring(cols)
end

local Component = {}

function Component.icon(props)
    local name = vim.api.nvim_buf_get_name(props.buf)
    local icon, color = devicons.get_icon_color(name ~= '' and vim.fn.fnamemodify(name, ':t') or '')
    return icon and { { icon .. ' ', guifg = color } } or {}
end

function Component.filename(props)
    local name = vim.api.nvim_buf_get_name(props.buf)
    local modified = vim.bo[props.buf].modified
    return badge(
        name ~= '' and vim.fn.fnamemodify(name, ':t') or '[No Name]',
        modified and 'InclineFilenameModified' or 'InclineFilename'
    )
end

function Component.diagnostics(props)
    local counts = vim.diagnostic.count(props.buf)
    local parts = {}
    for _, d in ipairs(DIAGNOSTICS) do
        local n = counts[vim.diagnostic.severity[d.severity]]
        if n and n > 0 then
            vim.list_extend(parts, badge(d.icon .. n, d.group))
        end
    end
    return parts
end

function Component.diff(props)
    local signs = vim.b[props.buf].gitsigns_status_dict
    local parts = {}
    for _, d in ipairs(signs and DIFF or {}) do
        local n = tonumber(signs[d.key])
        if n and n > 0 then
            vim.list_extend(parts, badge(d.icon .. n, d.group))
        end
    end
    return parts
end

function Component.branch(props)
    local signs = vim.b[props.buf].gitsigns_status_dict
    local head = signs and signs.head
    return (head and head ~= '') and badge(ICONS.branch .. head, 'InclineBranch') or {}
end

function Component.lsp(props)
    local names = vim.tbl_map(function(client)
        return client.name
    end, vim.lsp.get_clients({ bufnr = props.buf }))
    if #names == 0 then
        return {}
    end
    table.sort(names)
    return badge(ICONS.lsp .. table.concat(names, ' '), 'InclineLsp')
end

function Component.encoding(props)
    local text = vim.bo[props.buf].fileencoding
    local format = vim.bo[props.buf].fileformat
    if format ~= 'unix' then
        text = text ~= '' and (text .. ' ' .. format) or format
    end
    return text ~= '' and badge(text, 'InclineEncoding') or {}
end

function Component.search()
    if vim.v.hlsearch == 0 then
        return {}
    end
    local ok, res = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 100 })
    if not ok or (res.total or 0) == 0 then
        return {}
    end
    return badge(('%s%d/%d'):format(ICONS.search, res.current, res.total), 'InclineSearch')
end

function Component.selection()
    if not vim.fn.mode():match('^[vV\22]') then
        return {}
    end
    return badge(ICONS.selection .. visual_range(), 'InclineSearch')
end

function Component.position(props)
    local row, col = unpack(vim.api.nvim_win_get_cursor(props.win))
    return badge(('%d:%d'):format(row, col + 1), 'InclinePosition')
end

function Component.mode()
    local mode = MODES[vim.fn.mode()] or { vim.fn.mode():upper(), 'InclineModeNormal' }
    return badge(mode[1], mode[2])
end

local LEFT = { { 'icon' }, { 'filename' } }

-- Listed in display order. `keep` ranks them independently for the narrow
-- window case: the lowest is dropped first, so position and mode outlive the
-- encoding no matter where they sit in the bar.
local RIGHT = {
    { 'diagnostics', keep = 7 },
    { 'diff',        keep = 5 },
    { 'branch',      keep = 4 },
    { 'lsp',         keep = 2 },
    -- { 'encoding',    keep = 1 },
    { 'selection',   keep = 6 },
    { 'search',      keep = 3 },
    -- { 'position',    keep = 9 },
    { 'mode',        keep = 8 },
}

local function segments(entries, props)
    local out = {}
    for _, entry in ipairs(entries) do
        local parts = Component[entry[1]](props)
        if #parts > 0 then
            table.insert(out, { parts = parts, keep = entry.keep or math.huge })
        end
    end
    return out
end

local function flatten(segs)
    local out = {}
    for _, seg in ipairs(segs) do
        vim.list_extend(out, seg.parts)
    end
    return out
end

local function drop_lowest(segs)
    local lowest = 1
    for i, seg in ipairs(segs) do
        if seg.keep < segs[lowest].keep then
            lowest = i
        end
    end
    table.remove(segs, lowest)
end

require('incline').setup {
    window = {
        width = 'fill',
        placement = { vertical = 'top', horizontal = 'right' },
        margin = { horizontal = 0, vertical = 0 },
        padding = { left = 1, right = 1 },
        overlap = { borders = true, statusline = false, tabline = false, winbar = true },
    },
    hide = { cursorline = false },
    render = function(props)
        local left = flatten(segments(LEFT, props))
        if not props.focused then
            return left
        end

        local budget = vim.api.nvim_win_get_width(props.win) - 2 - width(left) - 1
        local segs = segments(RIGHT, props)
        local right = flatten(segs)
        while #segs > 0 and width(right) > budget do
            drop_lowest(segs)
            right = flatten(segs)
        end

        local gap = math.max(budget - width(right) + 1, 1)
        return vim.list_extend(vim.list_extend(left, { { string.rep(' ', gap) } }), right)
    end,
}

local group = vim.api.nvim_create_augroup('InclineRefresh', { clear = true })

-- Incline redraws on cursor and window events only, so these counts would
-- otherwise stay stale until the cursor moves.
vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = group,
    callback = function() require('incline').refresh() end,
})

vim.api.nvim_create_autocmd('User', {
    group = group,
    pattern = 'GitSignsUpdate',
    callback = function() require('incline').refresh() end,
})

-- A fill-width bar sits on the first text line, and incline hides itself when
-- the cursor reaches whatever it covers. Reserving a blank winbar gives the bar
-- a row of its own, on the same buffers incline's 'special' buftype filter
-- already draws into.
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinNew', 'FileType' }, {
    group = group,
    callback = function(ev)
        local win = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_get_config(win).relative ~= '' then
            return
        end
        local eligible = vim.bo[ev.buf].buftype == '' and vim.bo[ev.buf].buflisted
        vim.wo[win].winbar = eligible and ' ' or ''
    end,
})
