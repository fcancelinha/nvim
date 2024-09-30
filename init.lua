require('config.options')
require('config.keymaps')
require('config.lazy')

local opts = {
    brighter_comments = false,
    brighter_conditionals = false,
    italicized_comments = true,
    transparent = false,
}

local nordern = require('nordern')

nordern.setup(opts)
nordern.load()
