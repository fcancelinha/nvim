local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Plugins --

return packer.startup({function(use)
	-- Manager
	use 'wbthomason/packer.nvim' 

	-- Lua Development
	use 'nvim-lua/plenary.nvim' -- Useful lua functions used ny lots of plugins
	use 'nvim-lua/popup.nvim'

	-- Colorschemes
	use 'eddyekofo94/gruvbox-flat.nvim'
	use 'sainnhe/gruvbox-material'

	-- Icons
	use 'kyazdani42/nvim-web-devicons'

	-- Lualine
	use 'nvim-lualine/lualine.nvim'

	-- Snippets
	use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'


	-- Automatically set up your configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end,
config = {
	display = {
		open_fn = require('packer.util').float, -- make packer float
	}
}})
