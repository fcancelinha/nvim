return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"go",
				"bash",
				"css",
				"gomod",
				"gosum",
				"gowork",
				"html",
				"javascript",
				"typescript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"regex",
				"scss",
				"sql",
				"yaml",
			},
			highlight = {
				enable = true,
			},
		})
	end
}
