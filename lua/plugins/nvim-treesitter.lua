return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'VeryLazy',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'windwp/nvim-ts-autotag',
        'nvim-treesitter/nvim-treesitter-refactor',
        'b0o/schemastore.nvim',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('nvim-ts-autotag').setup({
            opts = {
                enable_close = true,         -- Auto close tags
                enable_rename = true,        -- Auto rename pairs of tags
                enable_close_on_slash = true -- Auto close on trailing </
            }
        })

        require('nvim-treesitter.configs').setup({
            ensure_installed = { 'go', 'gomod', 'gowork', 'gosum', 'lua', 'markdown', 'markdown_inline', 'vimdoc', 'bash', 'json', 'yaml', 'python', 'javascript', 'typescript', 'html', 'css' },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            refactor = {
                highlight_definitions = {
                    enable = true,
                    clear_on_cursor_move = true,
                },
                -- Note: smart_rename disabled - use native LSP rename (grn in Neovim 0.11+)
                smart_rename = {
                    enable = false,
                }
            },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer'
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer'
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer'
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer'
                    }
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>sp'] = '@parameter.inner'
                    },
                    swap_previous = {
                        ['<leader>sP'] = '@parameter.inner'
                    }
                }
            }
        })
    end,

}
