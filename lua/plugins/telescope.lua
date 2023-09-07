return {
	"nvim-telescope/telescope.nvim",
	tag = '0.1.1',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
		"ahmedkhalf/project.nvim",
		"nvim-telescope/telescope-symbols.nvim",
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
	end,
	opts = {
		extensions = {
			project = {
				base_dirs = {
					'~/code',
				},
				hidden_files = false, -- default: false
				theme = "dropdown",
				order_by = "asc",
				search_by = "title",
			}
		}
	}
}
