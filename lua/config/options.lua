vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--:help options
local options = {
	autoindent     = true,
	autoread       = true,
	autowrite      = true,
	background     = 'dark',
	backspace      = { 'start', 'eol', 'indent' },
	backup         = false,
	binary         = true,
	breakindent    = true,
	clipboard      = { 'unnamedplus' },
	cmdheight      = 1,
	completeopt    = { 'menu', 'menuone', 'preview' },
	conceallevel   = 0,
	confirm        = true,
	cursorline     = true,
	cursorlineopt  = 'line',
	encoding       = 'UTF-8',
	errorbells     = false,
	fileencoding   = 'UTF-8',
	hidden         = true,
	hlsearch       = true,
	ignorecase     = true,
	inccommand     = 'split',
	incsearch      = true,
	laststatus     = 5,
	linebreak      = true,
	list           = true,
	mouse          = 'a',
	number         = true,
	pumheight      = 20,
	relativenumber = true,
	ruler          = false,
	scrolloff      = 15,
	shell          = 'zsh',
	shiftround     = true,
	shiftwidth     = 4,
	showcmd        = false,
	showmatch      = true,
	showmode       = false,
	sidescrolloff  = 15,
	signcolumn     = 'yes',
	smartcase      = true,
	smarttab       = true,
	splitbelow     = true,
	splitright     = true,
	swapfile       = false,
	tabstop        = 4,
	termguicolors  = true,
	timeoutlen     = 1000,
	title          = true,
	undofile       = true,
	updatetime     = 100,
	visualbell     = true,
	wildmenu       = false,
	wrap           = false,
	writebackup    = false,
}

vim.opt.matchpairs:append "{:},<:>,':',\":\""
vim.opt.shortmess:append 'c'
vim.opt.whichwrap:append '<,>,[,],h,l'

for k, v in pairs(options) do
	vim.opt[k] = v
end
