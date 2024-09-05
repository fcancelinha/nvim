return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-refactor"
    },
    config = function()
        require('nvim-ts-autotag').setup({
            opts  = {
                enable_close = true,          -- Auto close tags
                enable_rename = true,         -- Auto rename pairs of tags
                enable_close_on_slash = true -- Auto close on trailing </
            }
        })

        require("nvim-treesitter.configs").setup({
            ensure_installed = { "go", "gomod", "gosum", "gowork", "templ" },
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
                smart_rename = {
                    enable = true,
                    -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
                    keymaps = {
                        smart_rename = "grr",
                    },
                }
            },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer"
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer"
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer"
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer"
                    }
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>sp"] = "@parameter.inner"
                    },
                    swap_previous = {
                        ["<leader>sP"] = "@parameter.inner"
                    }
                }
            }
        })
    end,

}
