return {
	'Vonr/align.nvim',
	branch = "v2",
	lazy = true,
	init = function()
		local NS = { noremap = true, silent = true }

		-- Aligns to 1 character
		vim.keymap.set(
			'x',
			'<leader>aa',
			function()
				require 'align'.align_to_char({
					length = 1,
				})
			end,
			NS
		)

		-- Aligns to 2 characters with previews
		vim.keymap.set(
			'x',
			'<leader>ad',
			function()
				require 'align'.align_to_char({
					preview = true,
					length = 2,
				})
			end,
			NS
		)

		-- Aligns to a string with previews
		vim.keymap.set(
			'x',
			'<leader>aw',
			function()
				require 'align'.align_to_string({
					preview = true,
					regex = false,
				})
			end,
			NS
		)

		-- Aligns to a Vim regex with previews
		vim.keymap.set(
			'x',
			'<leader>ar',
			function()
				require 'align'.align_to_string({
					preview = true,
					regex = true,
				})
			end,
			NS
		)

		-- Example gawip to align a paragraph to a string with previews
		vim.keymap.set(
			'n',
			'<leader>gaw',
			function()
				local a = require 'align'
				a.operator(
					a.align_to_string,
					{
						regex = false,
						preview = true,
					}
				)
			end,
			NS
		)

		-- Example gaaip to align a paragraph to 1 character
		vim.keymap.set(
			'n',
			'<leader>gaa',
			function()
				local a = require 'align'
				a.operator(a.align_to_char)
			end,
			NS
		) -- Create your mappings here
	end
}
