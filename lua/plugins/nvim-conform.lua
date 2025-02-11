return {
    'stevearc/conform.nvim',
    opts = {},
    lazy = false,
    config = function()
        require('conform').setup({
            formatters_by_ft = {
                yaml = { 'yamlfix' },
                json = { 'fixjson' },
                markdown = { 'mdformat' },
                javascript = { 'prettierd' },
                javascriptreact = { 'prettierd' },
                typescript = { 'prettierd' },
                typescriptreact = { 'prettierd' },
                bash = { 'shfmt' },
                shell = { 'shfmt' },
            },
            formatters = {
                yamlfix = {
                    env = {
                        YAMLFIX_SEQUENCE_STYLE = 'block_style',
                        YAMLFIX_EXPLICIT_START = 'false',
                        YAMLFIX_WHITELINES = '1',
                        YAMLFIX_COMMENTS_REQUIRE_STARTING_SPACE = 'true',
                        YAMLFIX_COMMENTS_MIN_SPACES_FROM_CONTENT = '0',
                        YAMLFIX_SECTION_WHITELINES = '2',
                        YAMLFIX_INDENT_MAPPING = '2',
                        YAMLFIX_INDENT_OFFSET = '2',
                        YAMLFIX_INDENT_SEQUENCE = '4',
                        YAMLFIX_LINE_LENGTH = '150',
                        YAMLFIX_quote_representation = '\"',
                    }
                },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = 'fallback',
            },
        })
    end,
}
