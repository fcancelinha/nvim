local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require "alpha.themes.dashboard"

local header = {
	type = "text",
	val = {
		"           ███████████████                 ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
		"           ███████████████                         ██        ",
		"           ███████████████                 ██████████████████",
		"           ███████████████                 ██              ██",
		"           ███████████████                 ██████████████████",
		"           ███████████████                     ██████████    ",
		"           ███████████████                   ███▀  ██  ▀███  ",
		"           ███████████████                 ███▀    ██    ▀███",
		"           ███████████████                                   ",
		"           ███████████████                 ██████████████████",
		"           ███████████████                      ██    ██     ",
		"           ███████████████                      ██    ██     ",
		"           ██████████████████████████      ██▀▀▀▀▀▀▀▀▀▀▀▀▀▀██",
		"           ██████████████████████████      ██              ██",
		"           ██████████████████████████      ▀▀▀▀▀██▀▀▀▀██▀▀▀▀▀",
		"           ██████████████████████████           ██    ██     ",
		"           ██████████████████████████           ██    ██     ",
		"           ██████████████████████████      ██████████████████",
		"           ██████████████████████████                        ",
		"           ██████████████████████████      ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
		"           ██████████████████████████      ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
		"           ██████████████████████████      ██████████████████",
		"           ███████████████▀▀▀▀▀▀▀▀▀▀▀      ██              ██",
		"           ███████████████                 ██████████████████",
		"          ███████████████                 ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
		"         ████████████████                 ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
		"        █████████████████                                   ",
		"       ██████████████████                 ██████████████████",
		"      ███████████████████                         ██        ",
		"     ████████████████████                         ██        ",
		"    █████████████████████                         ██        ",
		"   ██████████████████████                         ██        ",
		"  ███████████████████████                         ██        ",
		" ████████████████████████                         ██        ",
		"█████████████████████████                 ██████████████████",
	},
	opts = {
		position = "center",
		hl = "Text",
	}
}


local date = os.date(" %A, %b %d")

local heading = {
	type = "text",
	val = "𝗧𝗢𝗛𝗔 𝗛𝗘𝗔𝗩𝗬 𝗜𝗡𝗗𝗨𝗦𝗧𝗥𝗜𝗘𝗦     ⛬",
	opts = {
		position = "center",
		hl = "Conditional",
	}
}

local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		text = txt,
		shortcut = sc,
		width = 44,
		align_shortcut = "right",
		hl_shortcut = "Conditional",
		hl = "Conditonal",
	}
	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

local buttons = {
	type = "group",
	val = {
		button("f", " " .. " 𝗙𝗜𝗡𝗗 𝗙𝗜𝗟𝗘", ":Telescope find_files <CR>"),
		button("e", " " .. " 𝗡𝗘𝗪 𝗙𝗜𝗟𝗘", ":ene <BAR> startinsert <CR>"),
		button("p", " " .. " 𝗙𝗜𝗡𝗗 𝗣𝗥𝗢𝗝𝗘𝗖𝗧", ":lua require('telescope').extensions.projects.projects()<CR>"),
		button("r", " " .. " 𝗥𝗘𝗖𝗘𝗡𝗧 𝗙𝗜𝗟𝗘𝗦", ":Telescope oldfiles <CR>"),
		button("t", " " .. " 𝗙𝗜𝗡𝗗 𝗧𝗘𝗫𝗧", ":Telescope live_grep <CR>"),
		button("c", " " .. " 𝗖𝗢𝗡𝗙𝗜𝗚", ":e ~/.config/nvim/lua <CR>"),
		button("q", " " .. " 𝗤𝗨𝗜𝗧", ":qa<CR>"),
	},
	opts = {
		spacing = 1,
		hl = "Conditional"
	},
}

local footer = {
	type = "text",
	val = "Today is" .. date,
	opts = {
		position = "center",
		hl = "Conditional",
	}
}

local plugins_gen = io.popen('fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | head -n -2 | wc -l | tr -d "\n" ')
local plugins = plugins_gen:read("*a")
plugins_gen:close()


local footer_2 = {
	type = "text",
	val = "Authority downloaded " .. plugins .. " entities to base reality",
	opts = {
		position = "center",
		hl = "Conditional",
	},
}


local section = {
	header = header,
	heading = heading,
	buttons = buttons,
	footer = footer,
	footer_2 = footer_2,
}

local opts = {
	layout = {
		{ type = "padding", val = 1 },
		section.header,
		{ type = "padding", val = 1 },
		section.heading,
		{ type = "padding", val = 1 },
		section.buttons,
		{ type = "padding", val = 1 },
		section.footer,
		{ type = "padding", val = 0 },
		section.footer_2
	},
	opts = {
		margin = 44,
	},
}

alpha.setup(opts)
