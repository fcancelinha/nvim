return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        lazygit = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = { enabled = true }
    },
    keys = {
        { '<leader>gg', function() Snacks.lazygit() end,  desc = 'Lazygit' },
        { '<c-\\>',     function() Snacks.terminal() end, desc = 'Toggle Terminal' },
    }
}
