local nord_yellow      = "#EBCB8B"
local nord_green       = "#A3BE8C"
local nord_purple      = "#B48EAD"
local nord_red         = "#BF616A"
local nord_grey        = "#D8DEE9"
local nord_light_green = "#8FBCBB"
local nord_light_blue  = "#88C0D0"
local nord_light_cyan  = "#81A1C1"

--CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
--CmpItemKindKeyword = { fg = C.base, bg = C.red },
--CmpItemKindText = { fg = C.base, bg = C.teal },
--CmpItemKindMethod = { fg = C.base, bg = C.blue },
--CmpItemKindConstructor = { fg = C.base, bg = C.blue },
--CmpItemKindFunction = { fg = C.base, bg = C.blue },
--CmpItemKindFolder = { fg = C.base, bg = C.blue },
--CmpItemKindModule = { fg = C.base, bg = C.blue },
--CmpItemKindConstant = { fg = C.base, bg = C.peach },
--CmpItemKindField = { fg = C.base, bg = C.green },
--CmpItemKindProperty = { fg = C.base, bg = C.green },
--CmpItemKindEnum = { fg = C.base, bg = C.green },
--CmpItemKindUnit = { fg = C.base, bg = C.green },
--CmpItemKindClass = { fg = C.base, bg = C.yellow },
--CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
--CmpItemKindFile = { fg = C.base, bg = C.blue },
--CmpItemKindInterface = { fg = C.base, bg = C.yellow },
--CmpItemKindColor = { fg = C.base, bg = C.red },
--CmpItemKindReference = { fg = C.base, bg = C.red },
--CmpItemKindEnumMember = { fg = C.base, bg = C.red },
--CmpItemKindStruct = { fg = C.base, bg = C.blue },
--CmpItemKindValue = { fg = C.base, bg = C.peach },
--CmpItemKindEvent = { fg = C.base, bg = C.blue },
--CmpItemKindOperator = { fg = C.base, bg = C.blue },
--CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
--CmpItemKindCopilot = { fg = C.base, bg = C.teal },

-- Format cmp window colors
-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = nord_grey })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = nord_light_green })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { bg = 'NONE', fg = nord_yellow })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { bg = 'NONE', fg = nord_purple })
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = nord_purple })
vim.api.nvim_set_hl(0, 'CmpItemKindFunctionDefault', { bg = 'NONE', fg = nord_light_blue })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = nord_light_blue })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { bg = 'NONE', fg = nord_red })
vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { bg = 'NONE', fg = nord_yellow })
vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { bg = 'NONE', fg = nord_purple })
vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { bg = 'NONE', fg = nord_purple })
vim.api.nvim_set_hl(0, 'CmpItemKindModule', { bg = 'NONE', fg = nord_green })
vim.api.nvim_set_hl(0, 'CmpItemKindField', { bg = 'NONE', fg = nord_light_cyan })
vim.api.nvim_set_hl(0, 'CmpItemKindField', { bg = 'NONE', fg = nord_light_cyan })
vim.api.nvim_set_hl(0, 'CmpPmenuBorder', { bg = 'NONE', fg = nord_light_blue })


local TelescopePrompt = {
	TelescopeBorder = {
		fg = "#88C0D0",
	},
	TelescopeTitle = {
		fg = "#ECEFF4",
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
	NeoTreeFloatBorder = {
		fg = "#88C0D0"
	},
	NeoTreeDirectoryIcon = {
		fg = "#8FBCBB"
	}
}

for hl, col in pairs(TelescopePrompt) do
	vim.api.nvim_set_hl(0, hl, col)
end
