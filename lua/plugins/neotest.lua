return {
	"nvim-neotest/neotest",
	dependencies = {
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-plenary",
		-- Your other test adapters here
		"nvim-neotest/neotest-go",
		"nvim-neotest/neotest-vim-test",
	},
	config = function()
		-- get neotest namespace (api call creates or returns namespace)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")

		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message =
						diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)


		require("neotest").setup({
			adapters = {
				require("neotest-go")({
					experimental = {
						test_table = true,
					},
					args = { "-count=1", "-timeout=60s", "-json" }
				}),
			},
			default_strategy = 'integrated',
			output = {
				enabled = true,
				open_on_run = true,
				enter = true,
			},
			benchmark = {
				enabled = true,
			},
			diagnostic = {
				enabled = true,
				severity = 1,
			},
			consumers = {},
			strategies = {
				integrated = {
					width = 120,
					height = 40,
				},
			},
		})
	end,
}
