return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>cf',
            function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
            mode = { 'n', 'v' },
            desc = 'Format buffer',
        },
    },
    opts = {
        formatters_by_ft = {
            python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
            go = { 'goimports', 'gofumpt' },
        },
        format_on_save = {
            timeout_ms = 2000,
            lsp_format = 'fallback',
        },
    },
}
