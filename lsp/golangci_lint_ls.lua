return {
    cmd = { 'golangci-lint-langserver' },
    filetypes = { 'go', 'gomod' },
    init_options = {
        command = { 'golangci-lint', 'run' },
    },
}
