return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.5',
    dependencies = {
        "MunifTanjim/nui.nvim",
        "ThePrimeagen/git-worktree.nvim",
        "ahmedkhalf/project.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-telescope/telescope-symbols.nvim",
    },
    config = function()
        -- Extensions
        require("project_nvim").setup()
        require("git-worktree").setup()

        -- Load Extension
        require('telescope').load_extension('projects')
        require('telescope').load_extension('git_worktree')

        -- Setup
        require('telescope').setup({
            defaults = {
                layout_strategy    = "vertical",
                sorting_strategy   = "ascending",
                selection_strategy = "reset",
                selection_caret    = '◆ ',
                color_devicons     = true,
                winblend           = 5,
                layout_config      = {
                    vertical = {
                        width = 0.4,
                        height = 0.9,
                        mirror = true,
                        prompt_position = 'top',
                    }
                }
            },
            pickers = {
                find_files = {
                    prompt_title  = 'Find',
                    hidden        = true,
                    previewer     = false,
                    layout_config = {
                        height = 0.5,
                    }
                },
                oldfiles = {
                    prompt_title  = 'Recent',
                    preview_title = '',
                    hidden        = true,
                    layout_config = {
                        preview_height = 0.7,
                    }
                },
                grep_string = {
                    layout_config = {
                        width = 0.5,
                        preview_height = 0.7,
                    }
                },
                live_grep = {
                    layout_config = {
                        width = 0.5,
                        preview_height = 0.7,
                    }
                },
                diagnostics = {
                    layout_config = {
                        width = 0.5,
                    }
                },
                buffers = {
                    layout_config = {
                        width = 0.4,
                        preview_height = 0.7,
                    }
                },
                marks = {
                    layout_config = {
                        width = 0.4,
                        preview_height = 0.7,
                    }
                },
                git_branches = {
                    layout_config = {
                        width = 0.4,
                        preview_height = 0.7,
                    }
                },
                lsp_document_symbols = {
                    ignore_symbols = { "variable", "field" },
                    layout_config = {
                        width = 0.4,
                    }
                },
                quickfix = {
                    layout_config = {
                        width = 0.7,
                    }
                },
            },
            extensions = {
                git_worktrees = {
                    layout_config = {
                        width = 0.4
                    }
                }
            },
        })
    end,
}
