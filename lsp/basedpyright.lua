return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = {
        'python'
    },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        '.git',
    },
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = 'standard',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                diagnosticMode = 'openFilesOnly',
                inlayHints = {
                    variableTypes = true,
                    callArgumentNames = true,
                    functionReturnTypes = true,
                },
            },
        },
    },
}
