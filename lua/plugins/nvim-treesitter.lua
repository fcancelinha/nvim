return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"windwp/nvim-ts-autotag",
		{
			"https://github.com/apple/pkl-neovim",
			lazy = true,
			event = "BufReadPre *.pkl",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
			build = function()
				vim.cmd("TSInstall! pkl")
			end,
		},
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"css",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"html",
				"http",
				"javascript",
				"json",
				"json5",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"regex",
				"typescript",
				"vim",
				"vimdoc",
			},
			autotag = {
				enable = true,
				filetypes = { "html", "xml", "tsx", "markdown", "javascriptreact", "typescriptreact" }
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = { "typescript" },
			},
			indent = {
				enable = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn", -- set to `false` to disable one of the mappings
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
		})
	end,

}
