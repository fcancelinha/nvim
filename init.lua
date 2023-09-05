vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('config.options')
require('config.keymaps')
require('config.dbconns')
require('config.lazy')


vim.cmd[[
	colorscheme nord
]]
