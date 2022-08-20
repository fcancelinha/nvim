require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = { 
		"c",
		"lua",
		"rust",
		"go",
		"css",
		"html",
		"python",
		"json",
		"lua",
		"typescript",
		"javascript",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,
	-- Automatically install missing parsers when entering buffer
	auto_install = true,
	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		additional_vim_regex_highlighting = true,
	},
}
