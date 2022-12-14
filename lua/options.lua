-- :help options
local options = {
	autoindent = true, 			
	background = 'dark',
	backspace = {'start', 'eol', 'indent'},
	breakindent = true,
	clipboard = {'unnamed', 'unnamedplus'},
	completeopt = {'menu', 'menuone', 'noselect'},
	confirm = true,
	encoding = 'utf-8',
	errorbells = false,
	fileencoding = 'utf-8',
	hidden = true,
	hlsearch = true,
	ignorecase = true,
	inccommand = 'split',
	incsearch = true,
	laststatus = 2,
	lazyredraw = true,
	linebreak = true,
	mouse = 'a',
	number = true,
	relativenumber = true,
	ruler = false,
	scrolloff = 8,
	shell = 'zsh',
	shiftround = true,
	shiftwidth = 2,
	sidescrolloff = 15,
	signcolumn = 'yes',
	smartcase = true,
	smarttab = true,
	splitbelow = true,
	splitright = true,
	swapfile = true,
	tabstop = 2,
	termguicolors = true,
	timeoutlen = 1000,
	title = true,
	undofile = true,
	updatetime = 100,
	visualbell = true,
	wildmenu = true,
	wrap = false,
	wrap = true,
	writebackup = false,
	guifont = 'Hack:h9',
}

vim.opt.shortmess:append "c"
vim.opt.whichwrap:append "<,>,[,],h,l"

for k, v in pairs(options) do
	vim.opt[k] = v
end

