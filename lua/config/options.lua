vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--:help options
local options = {
	autoread       = true,
	autoindent     = true,
	autochdir      = true,
	autowrite      = true,
	background     = 'dark',
	backspace      = { 'indent', 'eol', 'start' },
	backup         = false,
	binary         = true,
	breakindent    = true,
	cindent        = true,
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
	laststatus     = 3,
	linebreak      = true,
	list           = true,
	mouse          = 'a',
	number         = true,
	pumheight      = 10,
	pumblend       = 10,
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
	smartindent    = true,
	splitbelow     = true,
	splitright     = true,
	swapfile       = false,
	tabstop        = 4,
	termguicolors  = true,
	timeoutlen     = 700,
	title          = true,
	undofile       = true,
	updatetime     = 100,
	visualbell     = false,
	wildmenu       = false,
	wrap           = true,
	writebackup    = false,
}

vim.opt.matchpairs:append "{:},<:>,':',\":\""
vim.opt.shortmess:append 'c'
vim.opt.whichwrap:append '<,>,[,],h,l'

if vim.fn.has('wsl') == 1 then
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			['+'] = 'clip.exe',
			['*'] = 'clip.exe',
		},
		paste = {
			['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enable = 0
	}
end

for k, v in pairs(options) do
	vim.opt[k] = v
end
