return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
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
				filetypes = { "html", "xml", "jsx", "tsx", "markdown", "javascriptreact", "typescriptreact" }
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,

}
