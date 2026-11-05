-- Read by the dashboard's startup section in lua/plugins/snacks.lua.
vim.g.start_time = vim.uv.hrtime()

require('config.options')     -- 1. Fundamental Vim settings
require('config.keymaps')     -- 2. User key mappings
require('config.autocmds')    -- 3. Core autocommands
require('config.filetypes')   -- 4. File type associations
require('core.pack')          -- 5. Plugin install (vim.pack)
require('plugins')            -- 6. Plugin configuration
require('core.lsp')           -- 7. LSP configuration
require('config.colorscheme') -- 8. Theme/colors last
