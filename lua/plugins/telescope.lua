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
				winblend        = 10,
			},
			pickers = {
				find_command = { "rg", "--glob", "!**/.git/*" },
				find_files = {
					theme = "dropdown",
					previewer = true,
					hidden = false,
				},
				oldfiles = {
					prompt_title = '',
					preview_title = '',
				},
				git_files = {
					hidden = false
				},
				marks = {
					theme = "dropdown",
				},
				git_branches = {
					theme = "dropdown",
				},
				lsp_document_symbols = {
					ignore_symbols = { "variable", "field" },
					theme = "dropdown",
				},
			},
			extensions = {
				project = {
					base_dirs = {
						'/home/fc/projects/',
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
