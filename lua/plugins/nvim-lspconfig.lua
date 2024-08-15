return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "junnplus/lsp-setup.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig.ui.windows").default_options.border = "single"

        local signs = { Error = "✚ ", Warn = " ", Hint = " ", Info = "󱧣 " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

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
                },
                cssls = {
                    capabilities = capabilities,
                },
                lua_ls = {
                    capabilities = capabilities,
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
                        },
                    },
                },
                gopls = {
                    capabilities = capabilities,
                    filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl" },
                    settings = {
                        gopls = {
                            diagnosticsDelay = '150ms',
                            experimentalPostfixCompletions = true,
                            semanticTokens = true,
                            matcher = 'Fuzzy',
                            gofumpt = true,
                            symbolMatcher = 'fuzzy',
                            vulncheck = "Imports",
                            hoverKind = "FullDocumentation",
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
                            staticcheck = true,
                            completeUnimported = true,
                            usePlaceholders = false,
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
                    capabilities = capabilities,
                    root_dir = require("lspconfig.util").root_pattern('angular.json', 'project.json'),
                },
                jsonls = {
                    capabilities = capabilities,
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
                    capabilities = capabilities,
                    settings = {
                        redhat = {
                            telemetry = {
                                enable = false,
                            },
                        },
                        yaml = {
                            editor = {
                                tabsize = 4
                            },
                            format = {
                                enable = true,
                                singleQuote = true,
                                bracketSpacing = true,
                            },
                            schemaStore = {
                                enable = true,
                            },
                            validate = true,
                            completion = true,
                            keyOrdering = false,
                        }
                    }
                },
                eslint = {
                    capabilities = capabilities,
                    on_attach = function(_, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end,
                    cmd = { "vscode-eslint-language-server", "--stdio" },
                    filetypes = {
                        "javascript",
                        "javascriptreact",
                        "javascript.jsx",
                        "typescript",
                        "typescriptreact",
                        "typescript.tsx",
                    },
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
                    capabilities = capabilities,
                    name = 'bash-language-server',
                    cmd = { 'bash-language-server', 'start' },
                    filetypes = { 'sh' }
                },
                gitlab_ci_ls = {
                    capabilities = capabilities,
                    filetypes = { "gitlab*" }
                },
                robotframework_ls = {
                    capabilities = capabilities,
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
                },
            }
        })
    end,
}
