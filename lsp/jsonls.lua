return {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    settings = {
        json = {
            validate = {
                enable = true,
            },
            format = {
                enable = true,
            },
            schemaStore = {
                enable = true,
                url = 'https://www.schemastore.org/api/json/catalog.json',
            },
            schemaDownload = {
                enable = true
            },
            schemas = {
                {
                    fileMatch = { 'package.json' },
                    url = 'https://json.schemastore.org/package.json'
                },
                {
                    fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
                    url = 'https://json.schemastore.org/tsconfig.json'
                },
                {
                    fileMatch = { '.eslintrc', '.eslintrc.json' },
                    url = 'https://json.schemastore.org/eslintrc.json'
                },
                {
                    fileMatch = { '.prettierrc', '.prettierrc.json' },
                    url = 'https://json.schemastore.org/prettierrc.json'
                },
            },
            trace = {
                server = 'messages' -- "off", "messages", "verbose"
            },
        }
    },
    init_options = {
        provideFormatter = true
    }
}
