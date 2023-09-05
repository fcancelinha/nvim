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

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Moving current lines
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- Close windows
keymap("n", "<leader>q", ":q<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Close Quickfix-List
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)
keymap("n", "<leader>cc", "<cmd>:ccl<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- [ Plugins ] --

-- Barbar
-- Move to previous/next
keymap('n', '<A-j>', '<Cmd>BufferPrevious<CR>', opts)
keymap('n', '<A-k>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
keymap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
keymap('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
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
keymap('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Close commands
keymap('n', '<A-c>', '<Cmd>BufferCloseAllButCurrent<CR>', opts)

-- Neotree
keymap("n", "\\", ":Neotree toggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects theme=dropdown<CR>", opts)
keymap("n", "<leader>fg", ":Telescope git_commits<CR>", opts)
keymap("n", "<leader>fh", ":Telescope marks<CR>", opts)
keymap("n", "<leader>fk", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fj", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fl", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fs", ":Telescope lsp_document_symbols ignore_symbols=variable,field theme=dropdown<CR>", opts)

-- Telescope LSP
keymap("n", "<leader>fr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>ft", ":Telescope lsp_implementations<CR>", opts)
keymap("n", "<leader>fy", ":Telescope lsp_incoming_calls<CR>", opts)
keymap("n", "<leader>fu", ":Telescope lsp_outgoing_calls<CR>", opts)

-- Telescope Trees
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

-- Snippets
keymap({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
keymap({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
keymap({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

keymap({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- LSP
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap('n', '<space>e', vim.diagnostic.open_float)
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		keymap('n', 'gD', vim.lsp.buf.declaration, opts)
		keymap('n', 'gd', vim.lsp.buf.definition, opts)
		keymap('n', 'K', vim.lsp.buf.hover, opts)
		keymap('n', 'gi', vim.lsp.buf.implementation, opts)
		keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		keymap('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		keymap('n', '<space>D', vim.lsp.buf.type_definition, opts)
		keymap('n', '<space>rn', vim.lsp.buf.rename, opts)
		keymap({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		keymap('n', 'gr', vim.lsp.buf.references, opts)
		keymap('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
