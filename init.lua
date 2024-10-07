require('config.options')
require('config.keymaps')
require('config.lazy')

local nordern = require('nordern')

nordern.setup({
    brighter_comments = false,
    brighter_conditionals = false,
    italic_comments = false,
    transparent = false,
})

nordern.load()
