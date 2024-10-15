return {
    'b0o/incline.nvim',
    -- lazy = false,
    -- event = 'VeryLazy',
    config = function()
        require('incline').setup({
            window = {
                margin = {
                    horizontal = 1,
                    vertical = 0
                },
                options = {
                    signcolumn = "yes",
                    wrap = false
                },
                overlap = {
                    borders = true,
                    statusline = false,
                    tabline = true,
                    winbar = true
                },
                padding = 1,
                padding_char = " ",
                placement = {
                    horizontal = "right",
                    vertical = "top"
                },
                width = "fit",
            },
            render = function(props)
                local modified = function()
                    if vim.bo.modified then
                        return '[+] '
                    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                        return '[-] '
                    end

                    return ' '
                end

                local function get_git_branch()
                    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")

                    if vim.v.shell_error ~= 0 then
                        return ""
                    end

                    return branch
                end

                local function get_git_diff()
                    local icons = { removed = '  ', changed = '  ', added = '  ' }
                    local signs = vim.b[props.buf].gitsigns_status_dict
                    local labels = {}

                    if signs == nil then
                        return labels
                    end

                    for name, icon in pairs(icons) do
                        if tonumber(signs[name]) and signs[name] > 0 then
                            table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
                        end
                    end

                    if #labels > 0 then
                        table.insert(labels, { ' ' })
                    end

                    return labels
                end

                local function get_diagnostic_label()
                    local icons = { Error = "✸ ", Warn = " ", Hint = " ", Info = " " }
                    local label = {}

                    for severity, icon in pairs(icons) do
                        local n = #vim.diagnostic.get(props.buf,
                            { severity = vim.diagnostic.severity[string.upper(severity)] })
                        if n > 0 then
                            table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
                        end
                    end

                    if #label > 0 then
                        table.insert(label, { ' ' })
                    end

                    return label
                end

                return {
                    { get_diagnostic_label() },
                    { '   ', group = 'String' },
                    { get_git_branch() or '', group = 'SpecialChar' },
                    { ' ' .. modified(), group = 'Error' },
                    { get_git_diff() },
                }
            end,
        })
    end,
}
