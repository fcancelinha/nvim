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
vim.g.mapleader = " "
keymap("", "<Space>", "<Nop>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts, { desc = "Indent left" })
keymap("v", ">", ">gv", opts, { desc = "Indent right" })

keymap('n', '[d', vim.diagnostic.goto_prev, opts, { desc = "Go to next diagnostic" })
keymap('n', ']d', vim.diagnostic.goto_next, opts, { desc = "Go to previous diagnostic" })

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("i", "<Up>", "<C-k>", opts)
keymap("i", "<Down>", "<C-j>", opts)

-- Moving current lines
keymap("n", "<A-j>", "mz:m+<CR>`z==", opts)
keymap("n", "<A-k>", "mz:m-2<CR>`z==", opts)
keymap("i", "<A-j>", "<Esc>:m+1<CR>==gi", opts)
keymap("i", "<A-k>", "<Esc>:m-2<CR>==gi", opts)
keymap("v", "<A-j>", ":m'>+<CR>gv=`<my`>mzgv`yo`z", opts)
keymap("v", "<A-k>", ":m'<-2<CR>gv=`>my`<mzgv`yo`z", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- [ Plugins ] --
--
-- Explorer
keymap("n", "\\", ":Neotree toggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":FzfLua files<CR>", opts)
keymap("n", "<leader>fD", ":FzfLua diagnostics<CR>", opts)
keymap("n", "<leader>fg", ":FzfLua git_files<CR>", opts)
keymap("n", "<leader>fG", ":FzfLua git_commits<CR>", opts)
keymap("n", "<leader>fB", ":FzfLua git_branches<CR>", opts)
keymap("n", "<leader>fm", ":FzfLua marks<CR>", opts)
keymap("n", "<leader>fj", ":FzfLua live_grep<CR>", opts)
keymap("n", "<leader>fk", ":FzfLua grep_cWORD<CR>", opts)
keymap("n", "<leader>fK", ":FzfLua grep_visual<CR>", opts)
keymap("n", "<leader>fl", ":FzfLua oldfiles<CR>", opts)
keymap("n", "<leader>fb", ":FzfLua buffers<CR>", opts)

-- Telescope LSP
keymap("n", "<leader>fr", ":FzfLua lsp_references<CR>", opts)
keymap("n", "<leader>fd", ":FzfLua lsp_definitions<CR>", opts)
keymap("n", "<leader>fs", ":FzfLua lsp_document_symbols<CR>", opts)
keymap("n", "<leader>fy", ":FzfLua lsp_implementations<CR>", opts)
keymap("n", "<leader>fi", ":FzfLua lsp_incoming_calls<CR>", opts)
keymap("n", "<leader>fo", ":FzfLua lsp_outgoing_calls<CR>", opts)

-- Neotest
keymap("n", "<leader>tn", function() require("neotest").run.run({ strategy = "dap" }) end, opts)
keymap("n", "<leader>tc", function() require("neotest").run.run(vim.fn.expand("%")) end, opts)
keymap("n", "<leader>ts", ":Neotest summary <CR>", opts)
keymap("n", "<leader>to", ":Neotest output-panel <CR>", opts)
keymap("n", "<leader>tr", ":Neotest run <CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Trouble
keymap("n", "<leader>xx", function() require("trouble").toggle() end, opts)
keymap("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, opts)
keymap("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, opts)
keymap("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, opts)
keymap("n", "<leader>xl", function() require("trouble").toggle("loclist") end, opts)
keymap("n", "gR", function() require("trouble").toggle("lsp_references") end, opts)

-- LuaSnips
keymap({ "i" }, "<Tab>", function() require('luasnip').expand() end, opts)
keymap({ "i", "s" }, "<Tab>", function() require('luasnip').jump(1) end, opts)
keymap({ "i", "s" }, "<S-Tab>", function() require('luasnip').jump(-1) end, opts)
keymap({ "i", "s" }, "<C-E>", function()
    if require('luasnip').choice_active() then
        require('luasnip').change_choice(1)
    end
end, opts)

-- GitBlame
keymap('n', '<leader>gb', "<cmd>lua require'gitsigns'.toggle_current_line_blame()<cr>", opts)
