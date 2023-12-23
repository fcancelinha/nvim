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
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Visual --
-- Stay in indent mode
keymap("v", ">", "<gv", opts)
keymap("v", "<", ">gv", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("i", "<Up>", "<C-k>", opts)
keymap("i", "<Down>", "<C-j>", opts)

-- Moving current lines
keymap("n", "<A-k>", ":m -1<CR>gv-gv", opts)
keymap("n", "<A-j>", ":m +1<CR>gv-gv", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close Quickfix-List
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)
keymap("n", "<leader>cc", "<cmd>:ccl<CR>", opts)

-- [ Plugins ] --

-- Neotree
keymap("n", "\\", ":Neotree toggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fg", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>fc", ":Telescope git_commits<CR>", opts)
keymap("n", "<leader>fm", ":Telescope marks<CR>", opts)
keymap("n", "<leader>fk", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fj", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fl", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fb", ":Telescope git_branches<CR>", opts)
keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts)

-- Telescope LSP
keymap("n", "<leader>fr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>ft", ":Telescope lsp_implementations<CR>", opts)
keymap("n", "<leader>fy", ":Telescope lsp_incoming_calls<CR>", opts)
keymap("n", "<leader>fu", ":Telescope lsp_outgoing_calls<CR>", opts)
keymap("n", "<leader>fw", ":Telescope git_worktrees git_worktrees<CR>", opts)

-- LazyGit
keymap("n", "<leader>gg", ":LazyGit<CR>", opts)

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
keymap("n", "<leader>xx", function() require("trouble").open() end)
keymap("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
keymap("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
keymap("n", "<leader>xq", function() require("trouble").open("quickfix") end)
keymap("n", "<leader>xl", function() require("trouble").open("loclist") end)
keymap("n", "gR", function() require("trouble").open("lsp_references") end)

-- LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', 'gl', vim.diagnostic.open_float, opts)
keymap('n', 'gq', vim.diagnostic.setloclist, opts)

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
		keymap('n', '<leader>f', function()
			vim.lsp.buf.format { async = true }
		end, lsp_opts)
	end,
})
