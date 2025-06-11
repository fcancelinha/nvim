return {
    cmd = { 'gopls' },
    on_attach = function()
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('goimports', {}),
            pattern = '*.go',
            callback = function()
                require('go.format').goimports()
            end,
        })
    end,
    settings = {
        gopls = {
            diagnosticsDelay = '100ms',
            experimentalPostfixCompletions = true,
            semanticTokens = true,
            noSemanticString = true,
            matcher = 'fuzzy',
            gofumpt = true,
            symbolMatcher = 'fuzzy',
            vulncheck = 'Imports',
            hoverKind = 'FullDocumentation',
            staticcheck = true,
            completeUnimported = true,
            usePlaceholders = true,
            codelenses = {
                gc_details         = true,
                debug              = true,
                generate           = true,
                run_govulncheck    = true,
                test               = true,
                tidy               = true,
                upgrade_dependency = true,
                regenerate_cgo     = true,
                vendor             = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            analyses = {
                nilness = true,
                assign = true,
                atomic = true,
                unusedparams = false,
                unusedvariable = false,
                unusedwrite = true,
                useany = true,
                unreachable = true,
                ST1003 = true,
                undeclaredname = true,
                nonewvars = true,
                fieldalignment = false,
                shadow = true,
                fillreturns = true,
            },
            directoryFilters = { '-.git', '-node_modules', '-.idea', '-.vscode-test', '-.vscode' },
            buildFlags = { '-tags', 'integration' },
        }
    },
    filetypes = {
        'go',
        'gomod',
        'gosum',
        'gowork',
        'gotmpl',
        'gohtmltmpl',
        'gotexttmpl',
    },

}
