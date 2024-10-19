return {
    'Bekaboo/dropbar.nvim',
    dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = function()
        local dropbar_picker = require 'dropbar.api' -- change from 'ai' to 'api'
        vim.keymap.set('n', '<leader>d', dropbar_picker.pick, { desc = '[D]ropbar Picker' })
    end,
}
