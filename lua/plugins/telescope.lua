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
    keys = {
        { "<leader>fB", ":Telescope git_branches<CR>",                                     desc = "Telescope git branches" },
        { "<leader>fc", ":Telescope git_commits<CR>",                                      desc = "Telescope git commits" },
        { "<leader>fD", ":Telescope diagnostics<CR>",                                      desc = "Telescope diagnostics" },
        { "<leader>fb", ":Telescope buffers<CR>",                                          desc = "Telescope buffers" },
        { "<leader>ff", ":Telescope find_files<CR>",                                       desc = "Telescope find files" },
        { "<leader>fg", ":Telescope git_files<CR>",                                        desc = "Telescope git files" },
        { "<leader>fj", ":Telescope live_grep<CR>",                                        desc = "Telescope live grep" },
        { "<leader>fk", ":Telescope grep_string<CR>",                                      desc = "Telescope grep string" },
        { "<leader>fl", ":Telescope oldfiles<CR>" , desc = "Telescope old files"},
        { "<leader>fm", ":Telescope marks<CR>" , desc = "Telescope marks"},
        { "<leader>fw", ":Telescope git_worktree<CR>" , desc = "Telescope git worktree"},
        { "<leader>fd", ":Telescope lsp_definitions<CR>" , desc = "Telescope definitions"},
        { "<leader>fi", ":Telescope lsp_incoming_calls<CR>" , desc = "Telescope incoming calls"},
        { "<leader>fo", ":Telescope lsp_outgoing_calls<CR>" , desc = "Telescope outgoing calls"},
        { "<leader>fr", ":Telescope lsp_references<CR>" , desc = "Telescope find references"},
        { "<leader>fs", ":Telescope lsp_document_symbols<CR>" , desc = "Telescope document symbols"},
        { "<leader>fy", ":Telescope lsp_implementations<CR>" , desc = "Telescope lsp implementations"},
        { "<leader>fp", function() require('telescope').extensions.projects.projects() end , desc = "Telescope projects"},
        { "<leader>ga", function() require("actions-preview").code_actions() end,          { "v", "n" }, desc = "Telescope code actions" }
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
                    prompt_title     = 'Find',
                    sorting_strategy = 'ascending',
                    previewer        = false,
                    layout_config    = {
                        vertical = {
                            width = 75,
                        }
                    }
                },
                oldfiles = {
                    previewer        = true,
                    prompt_title     = 'Recent',
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
                diagnostics = {
                    layout_config = {
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
                    layout_strategy = "horizontal",
                    ignore_symbols = { "variable", "field" },
                },
                lsp_references = {
                    layout_strategy = "horizontal",
                },
                lsp_definitions = {
                    layout_strategy = "horizontal",
                },
                lsp_incoming_calls = {
                    layout_strategy = "horizontal",
                },
                lsp_outgoing_calls = {
                    layout_strategy = "horizontal",
                },
                lsp_implementations = {
                    layout_strategy = "horizontal",
                },
                lsp_type_definitions = {
                    layout_strategy = "horizontal",
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
