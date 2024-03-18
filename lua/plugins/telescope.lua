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
		require('telescope').load_extension('projects')
		require('telescope').load_extension('git_worktree')
		require("project_nvim").setup()

		-- Setup
		require('telescope').setup({
			defaults = {
				-- layout_strategy = "center",
				selection_caret = '◆ ',
				color_devicons  = true,
				winblend        = 10,
				layout_config   = {
					width = 0.9,
					prompt_position = "top",
				},
			},
			pickers = {
				find_command = { "rg", "--glob", "!**/.git/*" },
				find_files = {
					theme         = "dropdown",
					previewer     = true,
					hidden        = false,
					layout_config = {
						width = 0.45,
					}
				},
				oldfiles = {
					prompt_title = '',
					preview_title = '',
					layout_config = {
						preview_width = 0.6,
					}
				},
				grep_string = {
					hidden = false,
					layout_config = {
						preview_width = 0.6,
					}
				},
				live_grep = {
					hidden = false,
					layout_config = {
						preview_width = 0.6,
					}
				},
				git_files = {
					hidden = false,
					layout_config = {
						preview_width = 0.6,
					}
				},
				lsp_incoming_calls = {
					hidden = false,
					layout_config = {
						preview_width = 0.6,
					}
				},
				lsp_outgoing_calls = {
					hidden = false,
					layout_config = {
						preview_width = 0.6,
					}
				},
				lsp_references = {
					hidden = false,
					layout_config = {
						preview_width = 0.6,
					}
				},
				buffers = {
					theme = "dropdown",
					layout_config = {
						width = 0.43,
					}
				},
				marks = {
					theme = "dropdown",
					layout_config = {
						width = 0.45,
					}
				},
				git_branches = {
					theme = "dropdown",
					layout_config = {
						width = 0.45,
					}
				},
				lsp_document_symbols = {
					ignore_symbols = { "variable", "field" },
					theme = "dropdown",
					layout_config = {
						width = 0.45,
					}
				},
				lsp_definitions = {
					ignore_symbols = { "variable", "field" },
					theme = "dropdown",
					layout_config = {
						width = 0.45,
					}
				},
			},
			extensions = {
				project = {
					base_dirs = {
						home .. '/projects/',
					},
					hidden = false, -- default: false
					theme = "dropdown",
					order_by = "asc",
					search_by = "title",
				}
			}
		})
	end,
}
