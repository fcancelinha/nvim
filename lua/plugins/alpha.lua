return {
	"goolord/alpha-nvim",
	lazy = true,
	event = "VimEnter",
	opts = function()
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header = {
			type = "text",
			val = {
				"           ███████████████                ██████████████████",
				"           ███████████████                        ██        ",
				"           ███████████████                ██████████████████",
				"           ███████████████                ██              ██",
				"           ███████████████                ██████████████████",
				"           ███████████████                    █ ██ █    ",
				"           ███████████████                   █  ██  █   ",
				"           ███████████████                  █   ██   █  ",
				"           ███████████████                                  ",
				"           ███████████████                ██████████████████",
				"           ███████████████                     ██    ██     ",
				"           ██████████████████████████     ██████████████████",
				"           ██████████████████████████     ██              ██",
				"           ██████████████████████████     ██████████████████",
				"           ██████████████████████████          ██    ██     ",
				"           ██████████████████████████     ██████████████████",
				"           ██████████████████████████                       ",
				"           ██████████████████████████     ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
				"           ██████████████████████████     ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
				"           ██████████████████████████     ██████████████████",
				"           ███████████████▀▀▀▀▀▀▀▀▀▀▀     ██              ██",
				"           ███████████████                ██████████████████",
				"          ███████████████                ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
				"         ████████████████                ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
				"        █████████████████                                  ",
				"       ██████████████████                ██████████████████",
				"      ███████████████████                        ██        ",
				"     ████████████████████                        ██        ",
				"    █████████████████████                        ██        ",
				"   ██████████████████████                        ██        ",
				"  ███████████████████████                        ██        ",
				" ████████████████████████                ██████████████████",
			},
			opts = {
				position = "center",
				hl = "Function"
			}
		}

		dashboard.section.subheader = {
			type = "text",
			val = "🀰 TOHA HEAVY INDUSTRIES 🀰",
			opts = {
				position = "center",
				hl = "Constant"
			},
		}

		local function button(sc, txt, keybind)
			local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

			local opts = {
				position = "center",
				text = txt,
				shortcut = '[' .. string.upper(sc) .. ']',
				width = 61,
				align_shortcut = "right",
				hl_shortcut = "Operator",
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

		dashboard.section.buttons.val = {
			{
				type = "text",
				val = "╭" .. string.rep("─", 58) .. "╮",
				opts = {
					hl = "FloatBorder",
					position = "center",
				}
			},
			button("f", "󰱼   " .. "Find File", ":Telescope find_files<CR>"),
			button("e", "󰦛   " .. "Restore Session", ":lua require('persistence').load({ last = true})<CR>"),
			button("p", "   " .. "Find Project", ":lua require('telescope').extensions.projects.projects{}<CR>"),
			button("r", "󰙰   " .. "Recent Files", ":Telescope oldfiles<CR>"),
			button("l", "󰏗   " .. "Pkg Manager", ":Lazy<CR>"),
			button("c", "   " .. "Config", ":Neotree ~/.config/nvim/lua<CR>"),
			button("q", "   " .. "Quit", ":qa<CR>"),
			{
				type = "text",
				val = "╰" .. string.rep("─", 58) .. "╯",
				opts = {
					hl = "FloatBorder",
					position = "center",
				},
			},
			{
				type = "text",
				val = "\n" .. "Recent Files: ",
				opts = {
					hl = "FloatBorder",
					position = "center",
				},
			},
		}

		dashboard.section.buttons.opts = {
			position = "center",
			spacing = 0,
		}
		dashboard.section.footer.opts.hl = "Function"

		-- Recent Files
		local recent_files = vim.v.oldfiles
		local devicon = require('nvim-web-devicons')

		for i, file in ipairs(recent_files) do
			if i > 7 then break end
			print(i .. file)
			local key = tostring(i)
			local file_name = file:match("^.+/(.+)$")
			local icon = devicon.get_icon(file_name, string.match(file_name, "^.+%.([^%.]+)$"), { default = true })

			table.insert(dashboard.section.buttons.val,
				button(key, icon .. "    " .. file_name, "<cmd>e " .. file .. " <CR>"))
		end

		dashboard.config.layout = {
			{ type = "padding", val = 0 },
			dashboard.section.header,
			{ type = "padding", val = 1 },
			dashboard.section.subheader,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
			{ type = "padding", val = 1 },
			dashboard.section.buttons,
		}

		return dashboard
	end,
	config = function(_, dashboard)
		require("alpha").setup(dashboard.opts)
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local v = vim.version()
				local dev = ""
				if v.prerelease == "dev" then
					dev = "-dev+" .. v.build
				else
					dev = ""
				end
				local version = v.major .. "." .. v.minor .. "." .. v.patch .. dev
				local stats = require("lazy").stats()
				local plugins_count = stats.loaded .. "/" .. stats.count
				local ms = math.floor(stats.startuptime + 0.5)
				local line1 = " " .. plugins_count .. " plugins in " .. ms .. "ms"
				local line3 = " " .. version

				local line1_width = vim.fn.strdisplaywidth(line1)
				local line3Padded = string.rep(" ", (line1_width - vim.fn.strdisplaywidth(line3)) / 2) .. line3

				dashboard.section.footer.val = {
					line1,
					line3Padded,
				}
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end
}
