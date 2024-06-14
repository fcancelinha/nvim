return {
    "goolord/alpha-nvim",
    lazy = true,
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local startify = require("alpha.themes.theta")
        local devicons = require("nvim-web-devicons")
        local lazy = require("lazy")

        local function surround(v)
            return ' ' .. v .. ' '
        end

        local function info_value()
            local total_plugins = lazy.stats().count
            local loaded_plugins = lazy.stats().loaded
            local datetime = os.date(surround('') .. '%d-%m-%Y')
            local version = vim.version()
            local nvim_version_info = surround(devicons.get_icon_by_filetype('vim', {}))
                .. version.major
                .. '.'
                .. version.minor
                .. '.'
                .. version.patch

            return surround('') ..
                total_plugins .. '/' .. loaded_plugins .. ' plugins ' .. nvim_version_info .. ' ' .. datetime
        end

        local info = {
            type = 'text',
            val = info_value(),
            opts = {
                hl = "Function",
                position = "center",
            }
        }

        local logo = {
            type = "text",
            val = {
                "          ███████████████               ██████████████████",
                "          ███████████████                       ██        ",
                "          ███████████████               ██████████████████",
                "          ███████████████               ██              ██",
                "          ███████████████               ██████████████████",
                "          ███████████████                   █ ██ █    ",
                "          ███████████████                  █  ██  █   ",
                "          ███████████████                 █   ██   █  ",
                "          ███████████████                                 ",
                "          ███████████████               ██████████████████",
                "          ███████████████                    ██    ██     ",
                "          █████████████████████████     ██████████████████",
                "          █████████████████████████     ██              ██",
                "          █████████████████████████     ██████████████████",
                "          █████████████████████████          ██    ██     ",
                "          █████████████████████████     ██████████████████",
                "          █████████████████████████                       ",
                "          █████████████████████████     ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
                "          █████████████████████████     ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
                "          █████████████████████████     ██████████████████",
                "          ███████████████▀▀▀▀▀▀▀▀▀▀     ██              ██",
                "          ███████████████               ██████████████████",
                "         ███████████████               ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
                "        ████████████████               ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
                "       █████████████████                                 ",
                "      ██████████████████               ██████████████████",
                "     ███████████████████                       ██        ",
                "    ████████████████████                       ██        ",
                "   █████████████████████                       ██        ",
                "  ██████████████████████                       ██        ",
                " ███████████████████████                       ██        ",
                "████████████████████████               ██████████████████",
            },
            opts = {
                position = "center",
                hl = "Function"
            }
        }

        local message = {
            type = "text",
            val = "🀰 TOHA HEAVY INDUSTRIES 🀰",
            opts = {
                position = "center",
                hl = "Constant"
            },
        }


        local function button(lhs, txt, rhs, opts)
            lhs = lhs:gsub('%s', ''):gsub('SPC', '<leader>')

            local default_opts = {
                position = 'center',
                shortcut = '[' .. lhs .. '] ',
                cursor = 1,
                width = 53,
                align_shortcut = 'right',
                hl_shortcut = { { 'Operator', 0, 1 }, { 'Function', 1, #lhs + 1 }, { 'Operator', #lhs + 1, #lhs + 2 } },
                shrink_margin = false,
                keymap = { 'n', lhs, rhs, { noremap = true, silent = true, nowait = true } },
            }

            opts = vim.tbl_deep_extend('force', default_opts, opts or {})

            return {
                type = 'button',
                val = string.format(' %-1s  %s', opts.icon or '', txt),
                on_press = function()
                    local key = vim.api.nvim_replace_termcodes(rhs .. '<Ignore>', true, false, true)
                    vim.api.nvim_feedkeys(key, 't', false)
                end,
                opts = opts,
            }
        end

        local buttons = {
            type = 'group',
            val = {
                {
                    type = "text",
                    val = string.rep("─", 50),
                    opts = {
                        hl = "FloatBorder",
                        position = "center",
                    }
                },
                button("f", "Find File", ":Telescope find_files<CR>",
                    { icon = '󰱼', hl = { { 'Constant', 0, 1 }, { 'Normal', 1, 50 } } }
                ),
                button("p", "Find Project", ":lua require('telescope').extensions.projects.projects{}<CR>",
                    { icon = '', hl = { { 'Constant', 0, 1 }, { 'Normal', 1, 50 } } }
                ),
                button("e", "Restore Session", ":lua require('persistence').load({ last = true})<CR>",
                    { icon = '󰦛', hl = { { 'Constant', 0, 1 }, { 'Normal', 1, 50 } } }
                ),
                -- button("n", "Notes", ":e ~/notes<CR>",
                --     { icon = '', hl = { { 'Constant', 0, 1 }, { 'Normal', 1, 50 } } }
                -- ),
                button("l", "PKG Manager", ":Lazy<CR>",
                    { icon = '󰏗', hl = { { 'Constant', 0, 1 }, { 'Normal', 1, 50 } } }
                ),
                button("c", "Config", ":Neotree ~/.config/nvim/lua<CR>",
                    { icon = '', hl = { { 'Constant', 0, 1 }, { 'Normal', 1, 50 } } }
                ),
                { type = 'padding', val = 1 },
                button("q", "Quit", ":qa<CR>",
                    { icon = '', hl = { { 'Constant', 0, 1 }, { 'Normal', 1, 50 } } }
                ),
                {
                    type = "text",
                    val = string.rep("─", 50),
                    opts = {
                        hl = "FloatBorder",
                        position = "center",
                    },
                },
            }
        }

        local mru = {
            type = 'group',
            val = {
                {
                    type = 'text',
                    val = 'Recent files',
                    opts = {
                        hl = 'Function',
                        position = 'center',
                    },
                },
                { type = 'padding', val = 1 },
                {
                    type = 'group',
                    val = function()
                        return { startify.mru(1, vim.fn.getcwd(), 5) }
                    end,
                },
            }
        }

        local config = {
            layout = {
                logo,
                { type = 'padding', val = 1 },
                message,
                { type = 'padding', val = 1 },
                mru,
                { type = 'padding', val = 1 },
                info,
                { type = 'padding', val = 1 },
                buttons,
                { type = 'padding', val = 1 },
            }
        }

        alpha.setup(config)
    end
}
