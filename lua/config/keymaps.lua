-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
local opts = { silent = true, noremap = true }

--Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = '<space>'
keymap('', '<Space>', '<Nop>', opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)

-- Better paste
-- keymap("v", "p", '"_dP', opts)

-- Exit insert mode
keymap('i', 'jk', '<Esc>', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('i', '<Up>', '<C-k>', opts)
keymap('i', '<Down>', '<C-j>', opts)

-- Terminal Navigation
-- keymap('t', 'jk', [[<C-\><C-n>]], opts)
keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

-- Moving current lines
keymap('n', '<A-j>', 'mz:m+<CR>`z==', opts)
keymap('n', '<A-k>', 'mz:m-2<CR>`z==', opts)
keymap('i', '<A-j>', '<Esc>:m+1<CR>==gi', opts)
keymap('i', '<A-k>', '<Esc>:m-2<CR>==gi', opts)
keymap('v', '<A-j>', ":m'>+<CR>gv=`<my`>mzgv`yo`z", opts)
keymap('v', '<A-k>', ":m'<-2<CR>gv=`>my`<mzgv`yo`z", opts)

-- Clear highlights
keymap('n', '<leader>h', '<cmd>nohlsearch<CR>', opts)
