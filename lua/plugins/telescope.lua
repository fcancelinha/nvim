return {
	"nvim-telescope/telescope.nvim",
	tag = '0.1.2',
	dependencies = {
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
				selection_caret = '◆ ',
				winblend        = 10,
			},
			pickers = {
				find_command = { "rg", "--glob", "!**/.git/*" },
				find_files = {
					theme = "dropdown",
					previewer = true,
					width = 2,
					hidden = false,
				},
				old_files = {
					prompt_title = '',
				},
				git_files = {
					hidden = false
				},
				git_commits = {
					theme = "dropdown",
					width = 2,
				},
				marks = {
					theme = "dropdown",
					width = 2,
				},
				lsp_document_symbols = {
					ignore_symbols = { "variable", "field" },
					theme = "dropdown",
				},
			},
			extensions = {
				project = {
					base_dirs = {
						home .. '/hdd/workspaces/',
					},
					hidden = false, -- default: false
					theme = "dropdown",
					order_by = "asc",
					search_by = "title",
					width = 0.8,
				}
			}
		})
	end,
}
