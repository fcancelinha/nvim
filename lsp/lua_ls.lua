return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            -- Note: lazydev.nvim handles vim globals and workspace library
            diagnostics = {
                globals = { 'vim' },
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
                    indent_style = 'space',
                    indent_size = '4',
                },
            },
            hint = {
                enable = false,
                setType = true,
                paramType = true,
            },
        },
    },
}
