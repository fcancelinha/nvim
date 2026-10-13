return {
    'romus204/tree-sitter-manager.nvim',
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    config = function()
        -- A bare setup() leaves ensure_installed empty and auto_install off, so
        -- no parser ever gets built: every filetype outside Neovim's seven
        -- bundled parsers falls back to legacy regex syntax, and nordern's
        -- @-capture highlights never fire.
        require('tree-sitter-manager').setup({
            auto_install = true,
            ensure_installed = {
                -- Go (primary stack)
                'go', 'gomod', 'gosum', 'gowork', 'gotmpl',
                -- Python (primary stack)
                'python', 'requirements',
                -- Config / data
                'json', 'yaml', 'toml', 'xml', 'sql', 'dockerfile', 'make',
                -- Web
                'html', 'css', 'javascript', 'typescript', 'tsx',
                -- Shell & docs
                'bash', 'lua', 'markdown', 'markdown_inline', 'vimdoc', 'vim', 'query',
                -- Git
                'git_config', 'gitignore', 'gitcommit', 'diff',
                -- Misc themed by nordern
                'http', 'robot', 'regex', 'printf', 'c',
            },
        })
    end,
}
