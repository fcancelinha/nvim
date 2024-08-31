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
vim.g.maplocalleader = '<space>'
keymap("", "<Space>", "<Nop>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)

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
-- Explorer
keymap("n", "\\", ":Neotree toggle<CR>", opts)

-- Telescope
keymap("n", "<leader>fB", ":Telescope git_branches<CR>", opts)
keymap("n", "<leader>fc", ":Telescope git_commits<CR>", opts)
keymap("n", "<leader>fD", ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fK", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>fj", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fk", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fl", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fm", ":Telescope marks<CR>", opts)
keymap("n", "<leader>fw", ":Telescope git_worktree<CR>", opts)

-- Telescope LSP
keymap("n", "<leader>fd", ":Telescope lsp_definitions<CR>", opts)
keymap("n", "<leader>fi", ":Telescope lsp_incoming_calls<CR>", opts)
keymap("n", "<leader>fo", ":Telescope lsp_outgoing_calls<CR>", opts)
keymap("n", "<leader>fr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts)
keymap("n", "<leader>fy", ":Telescope lsp_implementations<CR>", opts)

-- Telescope Extensions
keymap("n", "<leader>fp", function() require('telescope').extensions.projects.projects {} end, opts)
keymap({ "v", "n" }, "<leader>ga", function() require("actions-preview").code_actions() end, opts)

-- Neotest
keymap("n", "<leader>tr", function() require("neotest").run.run() end, opts)
keymap("n", "<leader>tn", function() require("neotest").run.run({ strategy = "dap" }) end, opts)
keymap("n", "<leader>td", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, opts)
keymap("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, opts)
keymap("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end, opts)
keymap("n", "<leader>tt", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, opts)
keymap("n", "<leader>tp", function() require("neotest").output_panel.toggle() end, opts)
keymap("n", "<leader>ts", function() require("neotest").summary.toggle() end, opts)

-- DAP
keymap("n", "<leader>db", function() require("dap").toggle_breakpoint() end, opts)
keymap("n", "<leader>dc", function() require("dap").continue() end, opts)
keymap("n", "<leader>di", function() require("dap").step_into() end, opts)
keymap("n", "<leader>do", function() require("dap").step_over() end, opts)
keymap("n", "<leader>dO", function() require("dap").step_out() end, opts)
keymap("n", "<leader>dr", function() require("dap").repl.toggle() end, opts)
keymap("n", "<leader>dl", function() require("dap").run_last() end, opts)
keymap("n", "<leader>dt", function() require("dap").terminate() end, opts)
keymap("n", "<leader>du", function() require("dapui").toggle() end, opts)

-- LuaSnips
keymap({ "i" }, "<Tab>", function() require('luasnip').expand() end, opts)
keymap({ "i", "s" }, "<Tab>", function() require('luasnip').jump(1) end, opts)
keymap({ "i", "s" }, "<S-Tab>", function() require('luasnip').jump(-1) end, opts)
keymap({ "i", "s" }, "<C-E>", function()
    if require('luasnip').choice_active() then
        require('luasnip').change_choice(1)
    end
end, opts)

-- Grug
keymap("n", "<leader>gr",
    function() require('grug-far').grug_far({ prefills = { search = vim.fn.expand("<cword>") } }) end,
    opts)

-- GitBlame
keymap('n', '<leader>gb', function() require("gitsigns").toggle_current_line_blame() end, opts)
