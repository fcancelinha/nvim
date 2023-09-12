return {
	"nvim-telescope/telescope.nvim",
	tag = '0.1.2',
	dependencies = {
		"ThePrimeagen/git-worktree.nvim",
		"ahmedkhalf/project.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
		"nvim-telescope/telescope-symbols.nvim",
	},
	config = function()
		local home = os.getenv("HOME")

		-- Extensions
		require('telescope').load_extension('projects')
		require('telescope').load_extension('git_worktree')

		-- Setup
		require('telescope').setup({
			defaults = {
				prompt_prefix = ' ',
				selection_caret = '» ',
			},
			-- pickers = {
			-- 	find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			-- },
			extensions = {
				project = {
					base_dirs = {
						home .. '/hdd/workspaces/',
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
