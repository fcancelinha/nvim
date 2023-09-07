require('config.options')
require('config.keymaps')
require('config.dbconns')
require('config.lazy')

vim.cmd [[
	colorscheme nord
]]

local TelescopePrompt = {
	TelescopeBorder = {
		fg = "#88C0D0",
	},
	TelescopePreviewBorder = {
		fg = "#88C0D0"
	},
	TelescopePromptBorder = {
		fg = "#88C0D0"
	},
	TelescopeResultsBorder = {
		fg = "#88C0D0"
	},
	TelescopeResultBorder = {
		fg = "#88C0D0"
	},
	TelescopeSelectionBorder = {
		fg = "#88C0D0"
	},
	NeoTreeFloatTitle = {
		fg = "#88C0D0"
	},
	NeoTreeFloatBorder = {
		fg = "#88C0D0"
	},
}

for hl, col in pairs(TelescopePrompt) do
	vim.api.nvim_set_hl(0, hl, col)
end
