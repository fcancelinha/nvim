return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "junnplus/lsp-setup.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("lspconfig.ui.windows").default_options.border = "single"
        local lspconfig = require 'lspconfig'

        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        local signs = { Error = "✸ ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end


        vim.api.nvim_create_autocmd('TextYankPost', {
            group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
            callback = function()
                vim.highlight.on_yank({ higroup = 'Yank', timeout = 200 })
            end,
        })

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(event)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local lsp_opts = { buffer = event.buf, silent = true, noremap = true }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, lsp_opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, lsp_opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, lsp_opts)
                vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, lsp_opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, lsp_opts)
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, lsp_opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, lsp_opts)
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, lsp_opts)
            end,
        })

        require('mason').setup({
            ui = {
                check_outdated_packages_on_open = true,
                border = "rounded",
                width = 80,
                height = 0.9,
            },
        })

        require('lsp-setup').setup({
            servers = {
                html = {
                    capabilities = capabilities,
                    filetypes = { 'html', 'html5', 'tmpl' },
                    settings = {
                        format = {
                            enable = true,
                            tabSize = 4,
                            indentInnerHtml = true,
                            preserveNewLines = true,
                        },
                        hover = {
                            documentation = true,
                            references = true,
                        },
                        suggest = {
                            html5 = true, -- Enable HTML5 tags
                        },
                    },
                    flags = {
                        debounce_text_changes = 150,
                        allow_incremental_sync = true,
                    }
                },
                cssls = {
                    capabilities = capabilities,
                    flags = {
                        debounce_text_changes = 150,
                        allow_incremental_sync = true,
                    }
                },
                lua_ls = {
                    capabilities = capabilities,
                    on_attach = function()
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            pattern = "*.lua",
                            callback = function()
                                vim.lsp.buf.format({ async = true })
                            end,
                        })
                    end,
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },
                            diagnostics = {
                                globals = {
                                    "vim",
                                    'use',
                                    'describe',
                                    'it',
                                    'assert',
                                    'before_each',
                                    'after_each',
                                }
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                            telemetry = {
                                enable = false,
                            },
                            format = {
                                enable = true,
                                defaultConfig = {
                                    indent_style = 'tab',
                                    indent_size = '4',
                                },
                            },
                            lint = {
                                enable = true,
                                command = "luacheck",
                                args = {
                                    "--globals",
                                    "vim",
                                    "--formatter",
                                    "plain",
                                    "--codes",
                                    "--ranges",
                                },
                            },
                        },
                    },
                    flags = {
                        debounce_text_changes = 150,
                        allow_incremental_sync = true,
                    }
                },
                golangci_lint_ls = {
                    capabilities = capabilities,
                    cmd = { 'golangci-lint-langserver' },
                    root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
                    init_options = {
                        command = { "golangci-lint", "run", "lll", "--out-format", "json", "--issues-exit-code=1" },
                    }
                },
                gopls = {
                    capabilities = capabilities,
                    on_attach = function()
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("goimports", {}),
                            pattern = "*.go",
                            callback = function()
                                require('go.format').goimports()
                            end,
                        })
                    end,
                    settings = {
                        gopls = {
                            diagnosticsDelay = '100ms',
                            experimentalPostfixCompletions = true,
                            semanticTokens = true,
                            matcher = 'fuzzy',
                            gofumpt = true,
                            symbolMatcher = 'fuzzy',
                            vulncheck = "Imports",
                            hoverKind = "FullDocumentation",
                            staticcheck = true,
                            completeUnimported = true,
                            usePlaceholders = true,
                            codelenses = {
                                gc_details         = true,
                                debug              = true,
                                generate           = true,
                                run_govulncheck    = true,
                                test               = true,
                                tidy               = true,
                                upgrade_dependency = true,
                                regenerate_cgo     = true,
                                vendor             = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                nilness = true,
                                assign = true,
                                atomic = true,
                                unusedparams = false,
                                unusedvariable = false,
                                unusedwrite = true,
                                useany = true,
                                unreachable = true,
                                ST1003 = true,
                                undeclaredname = true,
                                nonewvars = true,
                                fieldalignment = false,
                                shadow = true,
                                fillreturns = true,
                            },
                            directoryFilters = { "-.git", "-node_modules", "-.idea", "-.vscode-test", "-.vscode" },
                            buildFlags = { '-tags', 'integration' },
                        },
                    },
                    filetypes = {
                        "go",
                        "gomod",
                        "gosum",
                        "gowork",
                        "gotmpl",
                        "gohtmltmpl",
                        "gotexttmpl",
                    },
                    flags = {
                        debounce_text_changes = 150,
                        allow_incremental_sync = true,
                    }
                },
                angularls = {
                    capabilities = capabilities,
                    root_dir = require("lspconfig.util").root_pattern('angular.json', 'project.json'),
                },
                jsonls = {
                    capabilities = capabilities,
                    settings = {
                        json = {
                            schemas = {
                                {
                                    fileMatch = { "package.json" },
                                    url = "https://json.schemastore.org/package.json"
                                },
                                {
                                    fileMatch = { "tsconfig*.json" },
                                    url = "https://json.schemastore.org/tsconfig.json"
                                },
                                {
                                    fileMatch = { ".eslintrc.json", ".eslintrc" },
                                    url = "https://json.schemastore.org/eslintrc.json"
                                },
                                {
                                    fileMatch = { "prettierrc.json", "prettier.config.json" },
                                    url = "https://json.schemastore.org/prettierrc.json"
                                }
                            },
                        },
                        validate = {
                            enable = true
                        }
                    },
                },
                gitlab_ci_ls = {
                    capabilities = capabilities,
                    on_attach = function()
                        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                            pattern = "*.gitlab-ci*.{yml,yaml}",
                            callback = function()
                                vim.bo.filetype = "yaml.gitlab"
                            end,
                        })
                    end,
                    filetypes = { "*gitlab*" }
                },
                yamlls = {
                    capabilities = capabilities,
                    filetypes = { "yaml" },
                    settings = {
                        redhat = {
                            telemetry = {
                                enable = false,
                            },
                        },
                        yaml = {
                            schemaStore = {
                                enable = true,
                            },
                            format = {
                                enable = true,
                                printWidth = 150,      -- Corresponds to YAMLFIX_LINE_LENGTH
                                singleQuote = true,    -- Corresponds to YAMLFIX_quote_representation (set to single quote)
                                bracketSpacing = true, -- Aligns with adding spaces between brackets (not directly in YAMLFIX options)
                                proseWrap = "always",  -- This might help with formatting style settings for comments
                            },
                            indentation = {
                                mapping = 2,  -- Corresponds to YAMLFIX_INDENT_MAPPING
                                sequence = 4, -- Corresponds to YAMLFIX_INDENT_SEQUENCE
                                offset = 2,   -- Corresponds to YAMLFIX_INDENT_OFFSET
                            },
                            -- customTags = {
                            --     "YAMLFIX_SEQUENCE_STYLE=block_style",
                            --     "YAMLFIX_EXPLICIT_START=true",
                            --     "YAMLFIX_WHITELINES=1",
                            --     "YAMLFIX_COMMENTS_REQUIRE_STARTING_SPACE=true",
                            --     "YAMLFIX_COMMENTS_MIN_SPACES_FROM_CONTENT=2",
                            --     "YAMLFIX_SECTION_WHITELINES=2",
                            --     "YAMLFIX_INDENT_MAPPING=2",
                            --     "YAMLFIX_INDENT_OFFSET=2",
                            --     "YAMLFIX_INDENT_SEQUENCE=4",
                            --     "YAMLFIX_LINE_LENGTH=150",
                            --     "YAMLFIX_quote_representation='"
                            -- },
                            schemas = {
                                kubernetes = "/*.k8s.yaml",
                                ["http://json.schemastore.org/github-workflow"] = "/.github/workflows/*",
                                ["http://json.schemastore.org/github-action"] = "/.github/action.{yml,yaml}",
                                ["http://json.schemastore.org/drone"] = "/.drone.{yml,yaml}",
                                ["http://json.schemastore.org/chart"] = "/Chart.{yml,yaml}",
                            },
                            disable = { "gitlab-ci" },
                            validate = true,
                            completion = true,
                            hover = true,
                            keyOrdering = false,
                        }
                    }
                },
                bashls = {
                    capabilities = capabilities,
                    name = 'bash-language-server',
                    cmd = { 'bash-language-server', 'start' },
                    filetypes = { 'sh' }
                },
                sqls = {
                    capabilities = capabilities,
                },
            }
        })
    end,
}
