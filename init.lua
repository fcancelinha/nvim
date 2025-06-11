require('config.options')
require('config.keymaps')
require('config.filetypes')
require('config.autocmds')
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
