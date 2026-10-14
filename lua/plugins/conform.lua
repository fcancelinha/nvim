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
            -- ruff replaces black + isort + flake8 in a single binary
            python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
            -- goimports organizes imports (gopls will not do that on format
            -- alone); gofumpt then applies the stricter rules gopls was already
            -- configured for via settings.gopls.gofumpt.
            go = { 'goimports', 'gofumpt' },
        },
        -- Filetypes without an entry above fall through to the LSP formatter,
        -- which keeps lua_ls, yamlls, jsonls etc. behaving as before.
        format_on_save = {
            timeout_ms = 2000,
            lsp_format = 'fallback',
        },
    },
}
