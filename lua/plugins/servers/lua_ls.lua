return {
    on_attach = function()
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = '*.lua',
            callback = function()
                if vim.bo.buftype == '' then
                    vim.lsp.buf.format({ async = false })
                end
            end,
        })
    end,
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
