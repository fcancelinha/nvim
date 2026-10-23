return {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    opts = {
        formatters_by_ft = {
            go = {
                'goimports',
                'gofumpt',
            },
            python = {
                'ruff',
                'ruff_organize_imports',
                'ruff_format',
            },
            json = {
                'fixjson',
                'jq',
            },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = 'fallback',
        },
    },
}
