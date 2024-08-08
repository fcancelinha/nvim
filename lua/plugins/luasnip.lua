return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "2.*",
	build = vim.fn.has "win32" ~= 0 and "make install_jsregexp" or nil,
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
	end
}
