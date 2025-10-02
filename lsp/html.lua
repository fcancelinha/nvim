return {
    cmd = {
        'css',
        'scss',
        'less',
    },
    filetypes = {
        'html',
        'templ',
    },
    init_options = {
        configurationSection = {
            'html',
            'css',
            'javascript',
        },
        embeddedLanguages = {
            css = true,
            javascript = true
        },
        provideFormatter = true
    },
    root_markers = { 'package.json', '.git' },
    settings = {},
}
