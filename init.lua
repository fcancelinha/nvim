require('config.options')
require('config.keymaps')
require('config.autocommands')
require('config.lazy')

local opts = {
    italicized_comments = true,
    brighter_comments = true,
}

require('northern').load(opts)
