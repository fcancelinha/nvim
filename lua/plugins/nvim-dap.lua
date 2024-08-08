return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"antoinemadec/FixCursorHold.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local dap = require("dap")
		require("dapui").setup()

-- DAP
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error' })
vim.fn.sign_define('DapBreakpointCondition', { text = '󰯲', texthl = 'Conditional' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'Todo' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Exception' })
vim.fn.sign_define('DapStopped', { text = '󱆭', texthl = 'String' })
	end,
}
