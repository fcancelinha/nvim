return {
    "goolord/alpha-nvim",
    lazy = true,
    dependencies = {
        {
            "juansalvatore/git-dashboard-nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
    },
    event = "VimEnter",
    config = function()
        local lazy = require("lazy")
        local alpha = require("alpha")
        local startify = require("alpha.themes.theta")
        local devicons = require("nvim-web-devicons")

        local git_dashboard = require('git-dashboard-nvim').setup({
            top_padding = 0,
            bottom_padding = 0,
            show_current_branch = true,
            hide_cursor = false,
            centered = false,
            branch = 'main',
            use_git_username_as_author = false,
            show_only_weeks_with_commits = true,
            is_horizontal = true,
            empty_square = '▢',
            day_label_gap = '\t',
            gap = '  ',
            author = 'Filipe Cancelinha',
            filled_squares = { '■', '■', '■', '■', '■', '■' },
            basepoints = { "master", "main" },
            colors = {
                days_and_months_labels = '#6098A7',
                empty_square_highlight = '#88C0D0',
                filled_square_highlights = { '#002C39', '#094D5B', '#387180', '#6098A7', '#88C0D0', '#C0FAFF' },
                branch_highlight = '#EBCB8B',
                dashboard_title = '#88C0D0',
            },
        })

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

        local heatmap = {
            type = 'text',
            val = git_dashboard,
            opts = {
                position = "center"
            }
        }

        local info = {
            type = 'text',
            val = info_value(),
            opts = {
                hl = "Function",
                position = "center",
            }
        }

        -- local logo = {
        --     type = "text",
        --     val = {
        --         "          ███████████████               ██████████████████",
        --         "          ███████████████                       ██        ",
        --         "          ███████████████               ██████████████████",
        --         "          ███████████████               ██              ██",
        --         "          ███████████████               ██████████████████",
        --         "          ███████████████                   █ ██ █    ",
        --         "          ███████████████                  █  ██  █   ",
        --         "          ███████████████                 █   ██   █  ",
        --         "          ███████████████                                 ",
        --         "          ███████████████               ██████████████████",
        --         "          ███████████████                    ██    ██     ",
        --         "          █████████████████████████     ██████████████████",
        --         "          █████████████████████████     ██              ██",
        --         "          █████████████████████████     ██████████████████",
        --         "          █████████████████████████          ██    ██     ",
        --         "          █████████████████████████     ██████████████████",
        --         "          █████████████████████████                       ",
        --         "          █████████████████████████     ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
        --         "          █████████████████████████     ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀",
        --         "          █████████████████████████     ██████████████████",
        --         "          ███████████████▀▀▀▀▀▀▀▀▀▀     ██              ██",
        --         "          ███████████████               ██████████████████",
        --         "         ███████████████               ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
        --         "        ████████████████               ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄",
        --         "       █████████████████                                 ",
        --         "      ██████████████████               ██████████████████",
        --         "     ███████████████████                       ██        ",
        --         "    ████████████████████                       ██        ",
        --         "   █████████████████████                       ██        ",
        --         "  ██████████████████████                       ██        ",
        --         " ███████████████████████                       ██        ",
        --         "████████████████████████               ██████████████████",
        --     },
        --     opts = {
        --         position = "center",
        --         hl = "Function"
        --     }
        -- }
        --
        -- local message = {
        --     type = "text",
        --     val = "🀰 TOHA HEAVY INDUSTRIES 🀰",
        --     opts = {
        --         position = "center",
        --         hl = "Constant"
        --     },
        -- }

        local function button(lhs, txt, rhs, opts)
            lhs = lhs:gsub('%s', ''):gsub('SPC', '<leader>')

            local default_opts = {
                position = 'center',
                shortcut = '[' .. lhs .. '] ',
                cursor = 1,
                width = 52,
                align_shortcut = 'right',
                hl_shortcut = { { 'Keyword', 0, 1 }, { 'Constant', 1, #lhs + 1 }, { 'Keyword', #lhs + 1, #lhs + 2 } },
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
                button("f", "Find File", ":FzfLua files<CR>",
                    { icon = '󰱼', hl = { { 'Function', 1, 2 }, { 'Normal', 3, 52 } } }
                ),
                button("p", "Find Project", ":lua require('fzf-lua').files({ cwd = '~/projects/'}) <CR>",
                    { icon = '', hl = { { 'Error', 1, 2 }, { 'Normal', 3, 52 } } }
                ),
                button("e", "Restore Session", ":lua require('persistence').load({ last = true})<CR>",
                    { icon = '󰦛', hl = { { 'String', 1, 2 }, { 'Normal', 3, 52 } } }
                ),
                button("n", "Notes", ":e ~/notes<CR>",
                    { icon = '', hl = { { 'String', 1, 2 }, { 'Normal', 3, 52 } } }
                ),
                button("l", "PKG Manager", ":Lazy<CR>",
                    { icon = '󰏗', hl = { { 'Constant', 1, 2 }, { 'Normal', 3, 52 } } }
                ),
                button("c", "Config", ":Neotree ~/.config/nvim/lua<CR>",
                    { icon = '', hl = { { 'Keyword', 1, 2 }, { 'Normal', 3, 52 } } }
                ),
                { type = 'padding', val = 1 },
                button("q", "Quit", ":qa<CR>",
                    { icon = '', hl = { { 'Normal', 1, 2 }, { 'Normal', 3, 52 } } }
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
                    val = '-- Recent files --',
                    opts = {
                        hl = 'Function',
                        position = 'center',
                    },
                },
                { type = 'padding', val = 1 },
                {
                    type = 'group',
                    val = function()
                        return { startify.mru(1, vim.fn.getcwd(), 7) }
                    end,
                },
            }
        }

        local config = {
            layout = {
                heatmap,
                { type = 'padding', val = 1 },
                mru,
                { type = 'padding', val = 2 },
                buttons,
                { type = 'padding', val = 0 },
                info,
                { type = 'padding', val = 0 },
            }
        }

        alpha.setup(config)
    end
}
