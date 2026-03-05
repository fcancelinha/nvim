return {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    branch = 'v3.x',
    dependencies = {
        'MunifTanjim/nui.nvim',
        's1n7ax/nvim-window-picker',
    },
    keys = {
        { '\\', ':Neotree toggle<CR>', desc = 'open neotree file explorer' },
    },
    config = function()
        -- Prevent Neovim from changing cwd when opening files
        vim.opt.autochdir = false

        -- Find and set cwd to git root on startup
        local function find_git_root()
            local current_file = vim.fn.expand('%:p:h')
            local git_root = vim.fn.systemlist('git -C ' ..
                vim.fn.shellescape(current_file) .. ' rev-parse --show-toplevel')[1]
            if vim.v.shell_error == 0 then
                vim.cmd('cd ' .. git_root)
            end
        end

        -- Set to git root when opening files
        vim.api.nvim_create_autocmd('VimEnter', {
            callback = find_git_root,
        })
        require('window-picker').setup({
            filter_rules = {
                include_current_win = true,
                autoselect_one = true,
                bo = {
                    filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                    buftype = { 'terminal', 'quickfix' },
                },
            },
        })

        require('neo-tree').setup({
            close_if_last_window = false,
            popup_border_style = 'rounded',
            hide_root_node = false,
            retain_hidden_root_indent = true,
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { 'terminal', 'trouble', 'Outline', 'qf' },
            sort_case_insensitive = false,
            sort_function = nil,
            default_component_configs = {
                container = {
                    enable_character_fade = true
                },
                indent = {
                    indent_size = 3,
                    padding = 4,
                    with_markers = true,
                    indent_marker = '│',
                    last_indent_marker = '└',
                    highlight = 'NeoTreeIndentMarker',
                    with_expanders = true,
                    expander_collapsed = '',
                    expander_expanded = ' ',
                    expander_highlight = 'NeoTreeExpander',
                },
                icon = {
                    folder_closed = ' ',
                    folder_open = ' ',
                    folder_empty = ' ',
                    default = '',
                    highlight = 'NeoTreeFileIcon'
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = 'NeoTreeFileName',
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added     = ' ',
                        deleted   = ' ',
                        modified  = ' ',
                        renamed   = ' ',
                        -- Status type
                        untracked = ' ',
                        ignored   = ' ',
                        unstaged  = ' ',
                        staged    = '󰄵 ',
                        conflict  = ' ',
                    },
                    align = 'right'
                },
                diagnostics = {
                    symbols = {
                        hint = '',
                        info = '',
                        warn = '',
                        error = '',
                    },
                    highlights = {
                        hint = 'DiagnosticSignHint',
                        info = 'DiagnosticSignInfo',
                        warn = 'DiagnosticSignWarn',
                        error = 'DiagnosticSignError',
                    },
                },
                file_size = {
                    enabled = false,
                    required_width = 180,
                },
                type = {
                    enabled = true,
                    required_width = 180,
                },
                last_modified = {
                    enabled = true,
                    required_width = 180,
                },
                created = {
                    enabled = false,
                    required_width = 180,
                },
            },
            sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
            window = {
                position = 'float',
                popup = {
                    size = { height = '90%', width = 70 },
                    position = '50%',
                    padding = 15,
                },
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ['<space>'] = {
                        'toggle_node',
                        nowait = false,
                    },
                    ['<2-LeftMouse>'] = 'open',
                    ['<cr>'] = 'open',
                    ['<esc>'] = 'cancel',
                    ['P'] = { 'toggle_preview', config = { use_float = true } },
                    ['l'] = 'focus_preview',
                    ['S'] = 'open_split',
                    ['s'] = 'open_vsplit',
                    ['t'] = 'open_tabnew',
                    ['C'] = 'close_all_subnodes',
                    ['z'] = 'close_all_nodes',
                    ['Z'] = 'expand_all_nodes',
                    ['a'] = {
                        'add',
                        config = {
                            show_path = 'none'
                        }
                    },
                    ['A'] = 'add_directory',
                    ['d'] = 'delete',
                    ['r'] = 'rename',
                    ['y'] = 'copy_to_clipboard',
                    ['x'] = 'cut_to_clipboard',
                    ['p'] = 'paste_from_clipboard',
                    ['c'] = 'copy',
                    ['m'] = 'move',
                    ['q'] = 'close_window',
                    ['R'] = 'refresh',
                    ['?'] = 'show_help',
                    ['<'] = 'prev_source',
                    ['>'] = 'next_source',
                }
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = true,
                    hide_by_name = {
                        'node_modules',
                        '.node_modules',
                        '.yarn',
                    },
                    hide_by_pattern = {
                        '*.yarn',
                        '*.node_modules',
                    },
                    always_show = {
                        '.gitignore',
                        '.gitlab-ci.yml',
                        '.golangci.yml',
                        '.golangci.yaml',
                        '.robocop',
                    },
                    never_show = {
                        '.git'
                    },
                    never_show_by_pattern = {
                        '.null-ls_*',
                    },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
                group_empty_dirs = false,
                hijack_netrw_behavior = 'open_default',
                use_libuv_file_watcher = false,
                -- Keep neo-tree at git root, but update when changing projects
                bind_to_cwd = true,     -- Follow cwd changes (when you change projects)
                cwd_target = {
                    sidebar = 'global', -- Use global cwd (project root)
                    current = 'global',
                },
                window = {
                    mappings = {
                        ['<bs>'] = 'navigate_up',
                        ['.'] = 'set_root',
                        ['H'] = 'toggle_hidden',
                        ['/'] = 'fuzzy_finder',
                        ['D'] = 'fuzzy_finder_directory',
                        ['#'] = 'fuzzy_sorter',
                        ['f'] = 'filter_on_submit',
                        ['<c-x>'] = 'clear_filter',
                        ['[g'] = 'prev_git_modified',
                        [']g'] = 'next_git_modified',
                        ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
                    },
                    fuzzy_finder_mappings = {
                        ['<down>'] = 'move_cursor_down',
                        ['<C-j>'] = 'move_cursor_down',
                        ['<up>'] = 'move_cursor_up',
                        ['<C-k>'] = 'move_cursor_up',
                    },
                },
                commands = {}
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
                group_empty_dirs = false,
                show_unloaded = true,
                bind_to_cwd = true, -- Also follow cwd for buffers view
                window = {
                    mappings = {
                        ['bd'] = 'buffer_delete',
                        ['<bs>'] = 'navigate_up',
                        ['.'] = 'set_root',
                        ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
                    }
                },
            },
            git_status = {
                window = {
                    position = 'float',
                    mappings = {
                        ['A']  = 'git_add_all',
                        ['gu'] = 'git_unstage_file',
                        ['ga'] = 'git_add_file',
                        ['gr'] = 'git_revert_file',
                        ['gc'] = 'git_commit',
                        ['gp'] = 'git_push',
                        ['gg'] = 'git_commit_and_push',
                        ['o']  = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
                    }
                }
            }
        })
    end,
}
