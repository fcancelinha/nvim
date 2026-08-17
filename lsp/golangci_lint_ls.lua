return {
    cmd = { 'golangci-lint-langserver' },
    filetypes = { 'go', 'gomod' },
    init_options = {
        command = {
            'golangci-lint',
            'run',
            '--output.json.path=stdout',
            '--show-stats=false',
            '--issues-exit-code=1',
        },
    },
}
