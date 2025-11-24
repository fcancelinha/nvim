return {
    cmd = { 'lua-language-server' },
    filetypes = {
        'lua',
    },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'use',
                    'describe',
                    'it',
                    'assert',
                    'before_each',
                    'after_each',
                    'require'
                }
            },
            completion = {
                enable = true,
                callSnippet = 'Both',
                keywordSnippet = 'Replace',
            },
            workspace = {
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
            format = {
                enable = true,
                defaultConfig = {
                    quote_style = 'single',
                    indent_style = 'tab',
                    indent_size = '4',
                },
            },
            lint = {
                enable = true,
                command = 'luacheck',
                args = {
                    '--globals',
                    'vim',
                    '--formatter',
                    'plain',
                    '--codes',
                    '--ranges',
                },
            },
        },
    },

}
