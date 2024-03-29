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
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

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

-- Close Quickfix-List
keymap("n", "<leader>cc", "<cmd>:ccl<CR>", opts)
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)

-- [ Plugins ] --

-- Explorer
keymap("n", "\\", ":Neotree toggle<CR>", opts)

-- Terminal
keymap('n', '<A-i>', '<cmd>lua require("FTerm").toggle()<cr>', opts)
keymap('t', '<A-i>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>', opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fD", ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fg", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>fG", ":Telescope git_commits<CR>", opts)
keymap("n", "<leader>fB", ":Telescope git_branches<CR>", opts)
keymap("n", "<leader>fm", ":Telescope marks<CR>", opts)
keymap("n", "<leader>fk", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fj", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fl", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fw", ":Telescope git_worktree<CR>", opts)

-- Telescope LSP
keymap("n", "<leader>fr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>fd", ":Telescope lsp_definitions<CR>", opts)
keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts)
keymap("n", "<leader>fy", ":Telescope lsp_implementations<CR>", opts)
keymap("n", "<leader>fi", ":Telescope lsp_incoming_calls<CR>", opts)
keymap("n", "<leader>fo", ":Telescope lsp_outgoing_calls<CR>", opts)

-- Telescope Extensions
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)

-- LazyGit
keymap("n", "<leader>gg", ":LazyGit<CR>", opts)

-- Neotest
keymap("n", "<leader>tn", function() require("neotest").run.run({ strategy = "dap" }) end)

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

-- NeoTest
keymap("n", "<leader>tr", function() require("neotest").run.run() end)
keymap("n", "<leader>tc", function() require("neotest").run.run(vim.fn.expand("%")) end)

-- Trouble
keymap("n", "<leader>xx", function() require("trouble").toggle() end)
keymap("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
keymap("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
keymap("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
keymap("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
keymap("n", "gR", function() require("trouble").toggle("lsp_references") end)

-- Barbar
-- Move to previous/next
keymap('n', '<A-j>', '<Cmd>BufferPrevious<CR>', opts)
keymap('n', '<A-k>', '<Cmd>BufferNext<CR>', opts)
-- Goto buffer in position...
keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
keymap('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
keymap('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
keymap('n', '<A-q>', '<Cmd>BufferClose<CR>', opts)
keymap('n', '<A-Q>', '<Cmd>CloseAllButCurrent<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- LuaSnips
keymap({ "i" }, "<Tab>", function() require('luasnip').expand() end, opts)
keymap({ "i", "s" }, "<Tab>", function() require('luasnip').jump(1) end, opts)
keymap({ "i", "s" }, "<S-Tab>", function() require('luasnip').jump(-1) end, opts)
keymap({ "i", "s" }, "<C-E>", function()
	if require('luasnip').choice_active() then
		require('luasnip').change_choice(1)
	end
end, opts)

keymap('n', 'rr', '<Plug>RestNvim', { desc = 'execute request' }, opts)
keymap('n', 'rl', '<Plug>RestNvimPreview', { desc = 'preview curl' }, opts)
keymap('n', 'rp', '<Plug>RestNvimLast', { desc = 'repeat last request' }, opts)

-- LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local lsp_opts = { buffer = ev.buf }
		keymap('n', 'gD', vim.lsp.buf.declaration, lsp_opts)
		keymap('n', 'gd', vim.lsp.buf.definition, lsp_opts)
		keymap('n', 'gi', vim.lsp.buf.implementation, lsp_opts)
		keymap('n', 'go', vim.lsp.buf.type_definition, lsp_opts)
		keymap('n', 'gr', vim.lsp.buf.references, lsp_opts)
		keymap('n', 'gs', vim.lsp.buf.signature_help, lsp_opts)
		keymap('n', 'K', vim.lsp.buf.hover, lsp_opts)
		keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, lsp_opts)
		keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, lsp_opts)
		keymap('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, lsp_opts)
		keymap('n', '<leader>rn', vim.lsp.buf.rename, lsp_opts)
		keymap({ 'n', 'v' }, '<leader>ca', ":CodeActionMenu<CR>", lsp_opts)
	end,
})
