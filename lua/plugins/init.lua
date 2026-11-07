-- Plugin configuration, in load order. Each module sets up exactly one plugin
-- (or one tightly coupled group) and returns nothing.
--
-- mini.icons comes first because neo-tree, snacks, incline and
-- render-markdown all read it; snacks is next since it owns the dashboard and
-- the vim.ui surfaces other modules hook into.

local modules = {
    'mini-icons',
    'snacks',
    'blinkcmp',
    'mason',
    'copilot',
    'lazydev',
    'nvim-treesitter',
    'treesj',
    'autopair-surround',
    'mini-align',
    'gitsigns',
    'todo-comments',
    'trouble',
    'lualine',
    'dropbar',
    'neo-tree',
    'conform',
    'grug',
    'codediff',
    'nvim-highlight-colors',
    'markdown',
    'codecompanion',
    'bento',
    'neotest',
    'nvim-dap',
}

-- Isolated so a single broken module does not abort the rest of the config.
for _, name in ipairs(modules) do
    local ok, err = pcall(require, 'plugins.' .. name)
    if not ok then
        vim.notify(('plugins.%s: %s'):format(name, err), vim.log.levels.ERROR)
    end
end
