return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "junnplus/lsp-setup.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        require("lspconfig.ui.windows").default_options.border = "single"


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

        require("lsp-setup").setup({
            capabilities = capabilities,
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            diagnostics = {
                                globals = {
                                    'vim',
                                    'require',
                                    'enable',
                                    'ls',
                                    'actions',
                                },
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
                        },
                    },
                },
                gopls = {
                    settings = {
                        cmd = { "gopls" },
                        filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl" },
                        message_level = vim.lsp.protocol.MessageType.Error,
                        gopls = {
                            experimentalPostfixCompletions = true,
                            semanticTokens = true,
                            completeUnimported = true,
                            usePlaceholders = false,
                            staticcheck = true,
                            matcher = 'Fuzzy',
                            symbolMatcher = 'fuzzy',
                            diagnosticsDelay = '500ms',
                            codelenses = {
                                gc_details         = true,
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
                                unusedparams = true,
                                unusedvariable = true,
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
                    flags = {
                        debounce_text_changes = 500,
                        allow_incremental_sync = true,
                    }
                },
                angularls = {
                    root_dir = require("lspconfig.util").root_pattern('angular.json', 'project.json'),
                },
                jsonls = {
                    settings = {
                        json = {
                            format = {
                                enable = true
                            },
                            schemas = {
                                {
                                    fileMatch = { 'package.json' },
                                    url = 'https://json.schemastore.org/package.json',
                                },
                                {
                                    fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
                                    url = 'https://json.schemastore.org/tsconfig',
                                },
                                {
                                    fileMatch = { 'eslintrc.json' },
                                    url = 'https://json.schemastore.org/eslintrc.json',
                                },
                            },
                        },
                        validate = {
                            enable = true
                        }
                    },
                },
                yamlls = {
                    settings = {
                        redhat = {
                            telemetry = {
                                enable = false,
                            },
                        },
                        yaml = {
                            format = {
                                enable = true,
                                singleQuote = false,
                                bracketSpacing = true,
                            },
                            schemaStore = {
                                enable = true,
                            },
                            validate = true,
                            completion = true,
                        }
                    }
                },
                eslint = {
                    on_attach = function(_, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end,
                    flags = {
                        debounce_text_changes = 150,
                    },
                    cmd = { "vscode-eslint-language-server", "--stdio" },
                    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
                    handlers = {
                        ["eslint/confirmESLintExecution"] = function()
                            -- vim.cmd [[echom "confirmESLintExecution"]]
                            vim.notify("ESLint executing.", vim.log.levels.INFO)
                            return {}
                        end,
                        ["eslint/openDoc"] = function()
                            -- vim.cmd [[echom "openDoc"]]
                            vim.notify("Opening ESLint docs.", vim.log.levels.INFO)
                            return {}
                        end,
                        ["eslint/probeFailed"] = function()
                            vim.notify("ESLint probe failed.", vim.log.levels.WARN)
                            return {}
                        end,
                        ["eslint/noLibrary"] = function()
                            vim.notify("Unable to find ESLint library.", vim.log.levels.WARN)
                            return {}
                        end,
                    },
                    on_new_config = function(config, new_root_dir)
                        -- The "workspaceFolder" is a VSCode concept. It limits how far the
                        -- server will traverse the file system when locating the ESLint config
                        -- file (e.g., .eslintrc).
                        config.settings.workspaceFolder = {
                            uri = new_root_dir,
                            name = vim.fn.fnamemodify(new_root_dir, ':t'),
                        }
                    end,
                    settings = {
                        codeAction = {
                            disableRuleComment = {
                                enable = true,
                                location = "separateLine",
                            },
                            showDocumentation = {
                                enable = true,
                            }
                        },
                        codeActionOnSave = {
                            enable = true,
                            mode = "all"
                        },
                        format = true,
                        nodePath = "",
                        onIgnoredFiles = "off",
                        packageManager = "npm",
                        quiet = false,
                        rulesCustomizations = {
                            {
                                rule = "no-unused-vars",
                                severity = "off",
                            },
                        },
                        run = "onType",
                        useESLintClass = false,
                        validate = "on",
                        workingDirectory = {
                            mode = "location"
                        }
                    }
                },
                bashls = {
                    name = 'bash-language-server',
                    cmd = { 'bash-language-server', 'start' },
                    filetypes = { 'sh' }
                },
                gitlab_ci_ls = {
                    filetypes = { "gitlab*" }
                },
                robotframework_ls = {
                    cmd = { "/home/fc/.local/bin/robotframework_ls" },
                    settings = {
                        robot = {
                            pythonpath = "/usr/src/python3",
                            lint = {
                                enabled = true,
                                robocop = {
                                    enabled = true
                                }
                            }
                        }
                    }
                }
            }
        })
    end,
}
