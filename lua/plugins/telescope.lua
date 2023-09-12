return {
	"nvim-telescope/telescope.nvim",
	tag = '0.1.2',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
		"ahmedkhalf/project.nvim",
		"nvim-telescope/telescope-symbols.nvim",
		"ThePrimeagen/git-worktree.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build =
			'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
		},
	},
	config = function()
		-- Extensions
		require('telescope').load_extension('projects')
		require('telescope').load_extension('git_worktree')

		-- Setup
		require('telescope').setup({
			defaults = {
				prompt_prefix = ' ',
				selection_caret = '» ',
			},
			pickers = {
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			},
			extensions = {
				project = {
					base_dirs = {
						'~/hdd/workspaces/',
					},
					hidden_files = false, -- default: false
					theme = "dropdown",
					order_by = "asc",
					search_by = "title",
				}
			}
		})
	end,
}
