require('trouble').setup({})

local keys = {
    { '<leader>qx', '<cmd>Trouble diagnostics toggle<cr>',                     'Diagnostics (Trouble)' },
    { '<leader>qX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',        'Buffer Diagnostics (Trouble)' },
    { '<leader>o',  '<cmd>Trouble symbols toggle focus=true<cr>',              'Symbols (Trouble)' },
    { '<leader>ql', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', 'LSP Definitions / references (Trouble)' },
    { '<leader>qL', '<cmd>Trouble loclist toggle<cr>',                         'Location List (Trouble)' },
    { '<leader>qQ', '<cmd>Trouble qflist toggle<cr>',                          'Quickfix List (Trouble)' },
}

for _, map in ipairs(keys) do
    vim.keymap.set('n', map[1], map[2], { desc = map[3], silent = true })
end
