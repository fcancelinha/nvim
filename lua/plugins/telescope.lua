return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
        "MunifTanjim/nui.nvim",
        "ThePrimeagen/git-worktree.nvim",
        "ahmedkhalf/project.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "aznhe21/actions-preview.nvim",
    },
    config = function()
        local actions = require("telescope.actions")

        -- Extensions
        require("project_nvim").setup()
        require("git-worktree").setup()
        require("actions-preview").setup()

        -- Load Extension
        require('telescope').load_extension('projects')
        require('telescope').load_extension('git_worktree')
        require('telescope').load_extension('noice')

        -- Setup
        require('telescope').setup({
            defaults = {
                mappings         = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                    n = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
                prompt_prefix    = "󰭎 ",
                layout_strategy  = "vertical",
                selection_caret  = ' ',
                sorting_strategy = 'ascending',
                color_devicons   = true,
                winblend         = 5,
                layout_config    = {
                    vertical = {
                        width = 80,
                        height = 0.8,
                        mirror = true,
                        prompt_position = 'top',
                    },
                    horizontal = {
                        prompt_position = 'top'
                    }
                }
            },
            pickers = {
                find_files = {
                    find_command     = {
                        'fd',
                        '--type',
                        'f',
                        '--strip-cwd-prefix',
                        '--hidden',
                        '--follow',
                        '--exclude',
                        '.git',
                        '--exclude',
                        'node_modules',
                        '--exclude',
                        '.node_modules',
                    },
                    prompt_title     = 'find',
                    sorting_strategy = 'ascending',
                    previewer        = false,
                    layout_config    = {
                        vertical = {
                            width = 75,
                        }
                    }
                },
                oldfiles = {
                    previewer = true,
                    prompt_title     = 'recent',
                    -- preview_title    = '',
                    sorting_strategy = 'ascending',
                    hidden           = true,
                    layout_config    = {
                        vertical = {
                            width = 100,
                            height = 0.4,
                        }
                    }
                },
                buffers = {
                    previewer = false,
                    sorting_strategy = 'ascending',
                    results_title = '',
                    layout_config = {
                        vertical = {
                            width = 100,
                            height = 0.3,
                        }
                    }
                },
                grep_string = {
                    layout_strategy = "horizontal",

                },
                live_grep = {
                    layout_strategy = "horizontal",
                },
                highlights = {
                    layout_config = {
                        width = 80,
                    }
                },
                builtin = {
                    previewer = false,
                },
                lsp_document_symbols = {
                    ignore_symbols = { "variable", "field" },
                },
                keymaps = {
                    layout_config = {
                        vertical = {
                            mirror = false,
                            prompt_position = 'bottom',
                            width = 150,
                            height = 20,
                        }
                    }
                },
            },
        })
    end,
}
