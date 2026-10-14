local function drop_unused_hints(diagnostics)
    return vim.tbl_filter(function(d)
        return not (d.code == nil and d.message:match('^".-" is not accessed'))
    end, diagnostics or {})
end

-- Pyright resolves imports against whatever `python` it finds on PATH, which is
-- the brew interpreter, not the project's. Every third-party import then reports
-- reportMissingImports. Point it at the project venv instead.
-- The project's own venv wins over an activated one: nvim is often launched
-- from a shell with some unrelated VIRTUAL_ENV still exported.
local function resolve_python(root)
    for _, dir in ipairs({ '.venv', 'venv', 'env' }) do
        local py = root and (root .. '/' .. dir .. '/bin/python')
        if py and vim.uv.fs_stat(py) then
            return py
        end
    end
    if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. '/bin/python'
    end
    return vim.fn.exepath('python3')
end

return {
    cmd = { 'pyright-langserver', '--stdio' },
    before_init = function(_, config)
        config.settings.python.pythonPath = resolve_python(config.root_dir)
    end,
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git',
    },
    settings = {
        pyright = {
            -- ruff owns import sorting
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                -- Offer `from x import y` completions for symbols that are not
                -- imported yet, inserting the import as an additional edit.
                autoImportCompletions = true,
                diagnosticMode = 'openFilesOnly',
                typeCheckingMode = 'standard',
                -- Only affects the rule-based variants, which are off in
                -- 'standard' anyway. The grey-out hints are handled below.
                diagnosticSeverityOverrides = {
                    reportUnusedImport = 'none',
                    reportUnusedVariable = 'none',
                    reportUnusedExpression = 'none',
                },
            },
        },
    },
    handlers = {
        -- Pyright greys out unused symbols with a code-less HINT that no setting
        -- disables, duplicating ruff's F401/F841 (which carry an autofix).
        -- 'Code is structurally unreachable' has the same shape and is worth
        -- keeping, so match the message rather than the 'unnecessary' tag.
        -- Pyright registers diagnostics dynamically, so cover push and pull both.
        ['textDocument/publishDiagnostics'] = function(err, result, ctx)
            if result then
                result.diagnostics = drop_unused_hints(result.diagnostics)
            end
            return vim.lsp.handlers['textDocument/publishDiagnostics'](err, result, ctx)
        end,
        ['textDocument/diagnostic'] = function(err, result, ctx)
            if result then
                result.items = drop_unused_hints(result.items)
            end
            return vim.lsp.handlers['textDocument/diagnostic'](err, result, ctx)
        end,
    },
}
