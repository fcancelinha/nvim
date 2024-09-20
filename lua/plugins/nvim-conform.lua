return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                yaml = { "yamlfix" },
                json = { "fixjson" },
                go = { "gofumpt", "goimports" },
            },
            formatters = {
                yamlfix = {
                    env = {
                        YAMLFIX_SEQUENCE_STYLE = "block_style",
                        YAMLFIX_EXPLICIT_START = "true",
                        YAMLFIX_WHITELINES = "1",
                        YAMLFIX_COMMENTS_REQUIRE_STARTING_SPACE = "true",
                        YAMLFIX_COMMENTS_MIN_SPACES_FROM_CONTENT = "2",
                        YAMLFIX_SECTION_WHITELINES = "2",
                        YAMLFIX_INDENT_MAPPING = "2",
                        YAMLFIX_INDENT_OFFSET = "2",
                        YAMLFIX_INDENT_SEQUENCE = "4",
                        YAMLFIX_LINE_LENGTH = "150",
                        YAMLFIX_quote_representation = "'",
                    }
                },
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
    end
}
