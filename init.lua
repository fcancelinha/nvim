require('config.options')
require('config.filetypes')
require('config.keymaps')
require('config.lazy')

local nordern = require('nordern')

nordern.setup({
  brighter_comments = false,
  brighter_constants = false,
  italic_comments = false,
  transparent = false,
})

nordern.load()
