--:help options
local options = {
	autoindent = true,
	autowrite  = true,
	background = 'dark',
	backspace = {'start', 'eol', 'indent'},
	backup = false,
	binary = true,
	breakindent = true,
	clipboard = {'unnamed', 'unnamedplus'},
	cursorline = true,
	cursorlineopt = "number",
	completeopt = {'menu', 'menuone', 'noselect', 'preview'},
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
	linebreak = true,
	mouse = 'a',
	number = true,
	relativenumber = false,
	ruler = false,
	scrolloff = 8,
	shell = 'zsh',
	shiftround = true,
	shiftwidth = 4,
	showmatch = true,
	sidescrolloff = 15,
	signcolumn = 'yes',
	smartcase = true,
	smarttab = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	tabstop = 4,
	termguicolors = true,
	timeoutlen = 1000,
	title = true,
	undofile = true,
	updatetime = 100,
	visualbell = true,
	wildmenu = true,
	wrap = false,
	writebackup = false,
}

vim.opt.matchpairs:append "<:>,':',\":\""
vim.opt.shortmess:append "c"
vim.opt.whichwrap:append "<,>,[,],h,l"

for k, v in pairs(options) do
	vim.opt[k] = v
end
