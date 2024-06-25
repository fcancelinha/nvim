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
				layout_strategy  = "vertical",
				sorting_strategy = "descending",
				selection_caret  = '◆ ',
				color_devicons   = true,
				winblend         = 5,
				layout_config    = {
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
					find_command  = {
						'fd',
						'--type',
						'f',
						'--hidden',
						'--follow',
						'--exclude',
						'.git',
						'--exclude',
						'node_modules',
					},
					prompt_title  = 'Find',
					hidden        = true,
					previewer     = false,
					layout_config = {
						width = 65,
					}
				},
				oldfiles = {
					prompt_title  = 'Recent',
					preview_title = '',
					hidden        = true,
				},
				grep_string = {
					layout_config = {
						width = 80,
					}
				},
				highlights = {
					layout_config = {
						width = 80,
					}
				},
				live_grep = {
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
		})
	end,
}
