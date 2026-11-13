return {
    src = 'stevearc/conform.nvim',
    config = function()
        -- Sole owner of format-on-save. `lsp_format = 'fallback'` covers every
        -- filetype without a dedicated formatter below.
        require('conform').setup({
            formatters_by_ft = {
                go = {
                    'goimports',
                    'gofumpt',
                },
                markdown = {
                    'mdformat',
                },
                json = {
                    'jq',
                },
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_format = 'fallback',
            },
        })
    end,
}
