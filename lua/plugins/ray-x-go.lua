return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
	},
	config = function()
		require("go").setup({
			luasnip = true
		})
	end,
	event = { "CmdlineEnter" },
	ft = { "go", 'gomod' },
	build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
