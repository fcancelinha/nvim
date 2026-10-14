return {
    cmd = {
        'ruff',
        'server',
    },
    filetypes = {
        'python',
    },
    root_markers = {
        'pyproject.toml',
        'ruff.toml',
        '.ruff.toml',
        '.git',
    },
    -- pyright owns hover; two servers answering it produces duplicated docs
    on_attach = function(client)
        client.server_capabilities.hoverProvider = false
    end,
    init_options = {
        settings = {
            lineLength = 180,
            lint = {
                select = { 'E', 'F', 'I', 'UP', 'B', 'SIM', 'RUF' },
            },
        },
    },
}
