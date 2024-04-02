return {
	"nvim-neotest/neotest",
	dependencies = {
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-plenary",
		-- Your other test adapters here
		"nvim-neotest/neotest-go",
	},
	config = function()
		-- -- get neotest namespace (api call creates or returns namespace)
		-- local neotest_ns = vim.api.nvim_create_namespace("neotest")
		--
		-- vim.diagnostic.config({
		-- 	virtual_text = {
		-- 		format = function(diagnostic)
		-- 			local message =
		-- 				diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
		-- 			return message
		-- 		end,
		-- 	},
		-- }, neotest_ns)

		require("neotest").setup({
			adapters = {
				require("neotest-go")({
					recursive_run = true,
				}),
			},
			summary = {
				open = "botright vsplit | vertical resize 70"
			}
		})
	end,
}
