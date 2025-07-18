require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.filetypes')
require('core.lsp')
require('core.lazy')

local nordern = require('nordern')

nordern.setup({
    brighter_comments = false,
    brighter_constants = false,
    italic_comments = false,
    transparent = false,
})

nordern.load()
