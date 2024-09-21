return {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "s1n7ax/nvim-window-picker",
    },
    keys = {
        { "\\", ":Neotree toggle<CR>", desc = "open neotree file explorer" },
    },
    config = function()
        require 'window-picker'.setup({
            filter_rules = {
                include_current_win = true,
                autoselect_one = true,
                -- filter using buffer options
                bo = {
                    -- if the file type is one of following, the window will be ignored
                    filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                    -- if the buffer type is one of following, the window will be ignored
                    buftype = { 'terminal', "quickfix" },
                },
            },
        })

        require("neo-tree").setup({
            close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = "rounded",
            hide_root_node = false,
            retain_hidden_root_indent = true,
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { "terminal", "trouble", "Outline", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
            sort_case_insensitive = false,                                                -- used when sorting files and directories in the tree
            sort_function = nil,                                                          -- use a custom function for sorting files and directories in the tree
            default_component_configs = {
                container = {
                    enable_character_fade = true
                },
                indent = {
                    indent_size = 3,
                    padding = 4, -- extra padding on left hand side
                    -- indent guides
                    with_markers = false,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = " ",
                    expander_expanded = " ",
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_closed = "   ",
                    folder_open = " 󰷏  ",
                    folder_empty = " 󱞞  ",
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = "  ",
                    highlight = "NeoTreeFileIcon"
                },
                name = {
                    trailing_slash = true,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added     = " ",
                        deleted   = " ",
                        modified  = "󰜥 ",
                        renamed   = "> ",
                        -- Status type
                        untracked = "",
                        ignored   = "",
                        unstaged  = "󰘓",
                        staged    = "󰄬",
                        conflict  = "",
                    },
                    align = "right"
                },
                diagnostics = {
                    symbols = {
                        hint = "",
                        info = "",
                        warn = "",
                        error = "",
                    },
                    highlights = {
                        hint = "DiagnosticSignHint",
                        info = "DiagnosticSignInfo",
                        warn = "DiagnosticSignWarn",
                        error = "DiagnosticSignError",
                    },
                },
                -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
                file_size = {
                    enabled = false,
                    required_width = 180, -- min width of window required to show this column
                },
                type = {
                    enabled = true,
                    required_width = 180, -- min width of window required to show this column
                },
                last_modified = {
                    enabled = true,
                    required_width = 180, -- min width of window required to show this column
                },
                created = {
                    enabled = false,
                    required_width = 180, -- min width of window required to show this column
                },
            },
            -- A list of functions, each representing a global custom command
            -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
            -- see `:h neo-tree-custom-commands-global`
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            window = {
                position = "float",
                popup = {             -- settings that apply to float position only
                    size = { height = "90%", width = 70 },
                    position = "50%", -- 50% means center it
                    padding = 15,
                },
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<space>"] = {
                        "toggle_node",
                        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                    },
                    ["<2-LeftMouse>"] = "open",
                    ["<cr>"] = "open",
                    ["<esc>"] = "cancel", -- close preview or floating neo-tree window
                    ["P"] = { "toggle_preview", config = { use_float = true } },
                    ["l"] = "focus_preview",
                    ["S"] = "open_split",
                    ["s"] = "open_vsplit",
                    ["t"] = "open_tabnew",
                    -- ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                    -- ["C"] = "close_node",
                    ['C'] = 'close_all_subnodes',
                    ["z"] = "close_all_nodes",
                    ["Z"] = "expand_all_nodes",
                    ["a"] = {
                        "add",
                        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                        config = {
                            show_path = "none" -- "none", "relative", "absolute"
                        }
                    },
                    ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                    ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                    -- ["i"] = "show_file_details",
                }
            },
            filesystem = {
                filtered_items = {
                    visible = true, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = true, -- only works on Windows for hidden files/directories
                    hide_by_name = {
                        "node_modules",
                    },
                    hide_by_pattern = { -- uses glob style patterns
                        --"*.meta",
                        --"*/src/*/tsconfig.json",
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                        ".gitignore",
                        ".gitlab-ci.yml",
                        ".golangci.yml",
                        ".golangci.yaml",
                        ".robocop",
                    },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        --".DS_Store",
                        --"thumbs.db"
                        ".git"
                    },
                    never_show_by_pattern = { -- uses glob style patterns
                        ".null-ls_*",
                    },
                },
                follow_current_file = {
                    enabled = true,         -- This will find and focus the file in the active buffer every time
                    -- the current file is changed while the tree is open.
                    leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                group_empty_dirs = false,   -- when true, empty folders will be grouped together
                -- hijack_netrw_behavior = "open_current",
                -- netrw disabled, opening a directory opens neo-tree
                -- in whatever position is specified in window.position
                -- "open_current",  -- netrw disabled, opening a directory opens within the
                -- window like netrw would, regardless of window.position
                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                use_libuv_file_watcher = false,
                -- This will use the OS level file watchers to detect changes
                -- instead of relying on nvim autocmd events.
                -- bind_to_cwd = true,
                window = {
                    mappings = {
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["H"] = "toggle_hidden",
                        ["/"] = "fuzzy_finder",
                        ["D"] = "fuzzy_finder_directory",
                        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                        ["f"] = "filter_on_submit",
                        ["<c-x>"] = "clear_filter",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified",
                        ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                    },
                    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                        ["<down>"] = "move_cursor_down",
                        ["<C-j>"] = "move_cursor_down",
                        ["<up>"] = "move_cursor_up",
                        ["<C-k>"] = "move_cursor_up",
                    },
                },
                commands = {} -- Add a custom command or override a global one using the same function name
            },
            buffers = {
                follow_current_file = {
                    enabled = true,         -- This will find and focus the file in the active buffer every time
                    --              -- the current file is changed while the tree is open.
                    leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                group_empty_dirs = false,   -- when true, empty folders will be grouped together
                show_unloaded = true,
                window = {
                    mappings = {
                        ["bd"] = "buffer_delete",
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                    }
                },
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"]  = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push",
                        ["o"]  = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                    }
                }
            }

        })
    end,
}
