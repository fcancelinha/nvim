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
		require('telescope').load_extension('noice')

		-- Setup
		require('telescope').setup({
			defaults = {
				prompt_prefix   = " 󰭎 ",
				layout_strategy = "vertical",
				selection_caret = ' ',
				color_devicons  = true,
				winblend        = 5,
				layout_config   = {
					vertical = {
						width = 75,
						height = 0.9,
						mirror = true,
						prompt_position = 'top',
						preview_height = 0.7,
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
					hidden           = true,
					previewer        = false,
					layout_config    = {
						width = 65,
					}
				},
				oldfiles = {
					prompt_title  = 'recent',
					preview_title = '',
					hidden        = true,
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
			},
			extensions = {
				projects = {
					theme = "vertical",
				}
			}
		})
	end,
}
