return {
	"nvim-treesitter/nvim-treesitter",
	dependencies =  {
		"theHamsta/nvim-treesitter-pairs"
	},
	build = ":TSUpdate",
	config = function ()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"go",
				"bash",
				"css",
				"gomod",
				"gosum",
				"gowork",
				"html",
				"javascript",
				"typescript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"regex",
				"scss",
				"sql",
				"yaml",
			},
			highlight = {
				enable = true,
			},
		})
	end,
	opts ={
		pairs = {
			enable = true,
			disable = {},
			highlight_pair_events = {}, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
			highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
			goto_right_end = false, -- whether to go to the end of the right partner or the beginning
			fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
			keymaps = {
				goto_partner = "<leader>%",
				delete_balanced = "X",
			},
			delete_balanced = {
				only_on_first_char = false, -- whether to trigger balanced delete when on first character of a pair
				fallback_cmd_normal = nil, -- fallback command when no pair found, can be nil
				longest_partner = false, -- whether to delete the longest or the shortest pair when multiple found.
				-- E.g. whether to delete the angle bracket or whole tag in  <pair> </pair>
			}
		},
		incremental_selection = {
			enable = enable,
			keymaps = {
				-- mappings for incremental selection (visual mappings)
				init_selection = "gnn", -- maps in normal mode to init the node/scope selection
				node_incremental = "grn", -- increment to the upper named parent
				scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
				node_decremental = "grm" -- decrement to the previous node
			}
		},

		textobjects = {
			-- syntax-aware textobjects
			enable = enable,
			lsp_interop = {
				enable = enable,
				peek_definition_code = {
					["DF"] = "@function.outer",
					["DF"] = "@class.outer"
				}
			},
			keymaps = {
				["iL"] = {
					-- you can define your own textobjects directly here
					go = "(function_definition) @function",
				},
				-- or you use the queries from supported languages with textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["ae"] = "@block.outer",
				["ie"] = "@block.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["is"] = "@statement.inner",
				["as"] = "@statement.outer",
				["ad"] = "@comment.outer",
				["am"] = "@call.outer",
				["im"] = "@call.inner"
			},
			move = {
				enable = enable,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer"
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer"
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer"
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer"
				}
			},
			select = {
				enable = enable,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					-- Or you can define your own textobjects like this
					["iF"] = {
						python = "(function_definition) @function",
						cpp = "(function_definition) @function",
						c = "(function_definition) @function",
						java = "(method_declaration) @function",
						go = "(method_declaration) @function"
					}
				}
			},
			swap = {
				enable = enable,
				swap_next = {
					["<leader>a"] = "@parameter.inner"
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner"
				}
			}
		}
	}
}
