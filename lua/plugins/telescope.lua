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
		local home = os.getenv("HOME")

		-- Extensions
		require("project_nvim").setup()
		require("git-worktree").setup()

		-- Load Extension
		require('telescope').load_extension('projects')
		require('telescope').load_extension('git_worktree')

		-- Setup
		require('telescope').setup({
			defaults = {
				-- layout_strategy = "center",
				sorting_strategy = "descending",
				selection_caret  = '◆ ',
				color_devicons   = true,
				winblend         = 10,
				layout_config    = {
					width = 0.4,
					height = 0.4,
				}
			},
			pickers = {
				find_command = { "fd", "--type", "f", },
				find_files = {
					theme         = "dropdown",
					previewer     = true,
					hidden        = false,
					layout_config = {
						width = 0.4,
					}
				},
				oldfiles = {
					prompt_title = '',
					preview_title = '',
					layout_config = {
						width = 0.8,
						height = 0.7,
						preview_width = 0.6,
					}
				},
				grep_string = {
					hidden = false,
					layout_config = {
						width = 0.8,
						height = 0.8,
						preview_width = 0.6,
					}
				},
				live_grep = {
					hidden = false,
					layout_config = {
						width = 0.8,
						height = 0.8,
						preview_width = 0.6,
					}
				},
				git_files = {
					hidden = false,
					layout_config = {
						width = 0.8,
						height = 0.8,
						preview_width = 0.6,
					}
				},
				git_commits = {
					layout_config = {
						width = 0.8,
						height = 0.8,
						preview_width = 0.6,
					}
				},
				lsp_incoming_calls = {
					hidden = false,
					layout_config = {
						width = 0.8,
						height = 0.8,
						preview_width = 0.6,
					}
				},
				lsp_outgoing_calls = {
					hidden = false,
					layout_config = {
						width = 0.8,
						height = 0.8,
						preview_width = 0.6,
					}
				},
				lsp_references = {
					hidden = false,
					layout_config = {
						width = 0.8,
						height = 0.8,
						preview_width = 0.6,
					}
				},
				lsp_definitions = {
					hidden = false,
					layout_config = {
						width = 0.8,
						height = 0.7,
						preview_width = 0.6,
					}
				},
				highlights = {
					layout_config = {
						width = 0.8,
						height = 0.9,
					},
				},
				search_history = {
					layout_config = {
						width = 0.8,
						height = 0.9,
					},
				},
				builtin = {
					layout_config = {
						width = 0.8,
						height = 0.9,
					},
				},
				diagnostics = {
					theme = "dropdown",
					layout_config = {
						width = 0.7,
					}
				},
				buffers = {
					theme = "dropdown",
					layout_config = {
						width = 0.4,
					}
				},
				marks = {
					theme = "dropdown",
					layout_config = {
						width = 0.4,
					}
				},
				git_branches = {
					theme = "dropdown",
					layout_config = {
						width = 0.4,
					}
				},
				lsp_document_symbols = {
					ignore_symbols = { "variable", "field" },
					theme = "dropdown",
					layout_config = {
						width = 0.4,
					}
				},
				quickfix = {
					theme = "dropdown",
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
