return {
	"folke/neodev.nvim",
    lazy = false,
	opts = {
		library = {
			enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
			-- these settings will be used for your Neovim config directory
			plugins = { "neotest", "nvim-treesitter", "plenary.nvim", "telescope.nvim", "nvim-dap-ui" },
			runtime = true, -- runtime path
			types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
			-- plugins = true, -- installed opt or start plugins in packpath
			-- you can also specify the list of plugins to make available as a workspace library
		},
	},
	config = function()
		require("neodev").setup()
	end,
}
