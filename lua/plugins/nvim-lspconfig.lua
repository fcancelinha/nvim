return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local lspconfig = require('lspconfig')
        local util = require('lspconfig.util')

        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require('mason').setup({
            ui = {
                check_outdated_packages_on_open = true,
                border = 'rounded',
                width = 80,
                height = 0.9,
            },
        })

        require('lspconfig.ui.windows').default_options.border = 'rounded'
        local signs = { Error = '✸ ', Warn = ' ', Hint = ' ', Info = ' ' }
        for type, icon in pairs(signs) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
        end

        vim.api.nvim_create_autocmd('TextYankPost', {
            group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
            callback = function()
                vim.highlight.on_yank({ higroup = 'Yank', timeout = 200 })
            end,
        })

        vim.api.nvim_create_autocmd('VimLeavePre', {
            pattern = '*',
            callback = function()
                for _, job in ipairs(vim.fn.joblist()) do
                    vim.fn.jobstop(job)
                end
            end,
        })

        local on_attach = function()
            vim.api.nvim_create_autocmd('BufWritePre', {
                callback = function(args)
                    require('conform').format({ bufnr = args.buf })
                end,
            })
        end

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
                vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, lsp_opts)
            end,
        })


        local servers = {
            html = {
                on_attach = on_attach,
                filetypes = { 'html', 'html5' },
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
                on_attach = on_attach,
                flags = {
                    debounce_text_changes = 150,
                    allow_incremental_sync = true,
                }
            },
            ts_ls = {
                on_attach = function(client, bufnr)
                    if client.server_capabilities.semanticTokensProvider then
                        vim.lsp.semantic_tokens.start(bufnr, client.id)
                    end
                end,
                preferences = {
                    quotePreference = 'single',
                    organizeImportsCollation = 'ordinal',
                    organizeImportsCollationLocale = 'en',
                    includePackageJsonAutoImports = 'on',
                    importModuleSpecifierPreference = 'relative',
                    includeAutomaticOptionalChainCompletions = true,
                    includeCompletionsWithInsertText = true,
                },
                format = {
                    indentSize = 4,
                    tabSize = 4,
                    convertTabsToSpaces = true,
                    insertSpaceAfterCommaDelimiter = true,
                    insertSpaceAfterConstructor = false,
                    insertSpaceAfterSemicolonInForStatements = true,
                    insertSpaceBeforeAndAfterBinaryOperators = true,
                    insertSpaceAfterKeywordsInControlFlowStatements = true,
                    insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = false,
                    insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
                    placeOpenBraceOnNewLineForControlBlocks = true,
                    placeOpenBraceOnNewLineForFunctions = true,
                },
            },
            eslint = {
                cmd = { 'yarn', 'eslint', '--stdin', '--stdin-filename', function()
                    return vim.api.nvim_buf_get_name(0)
                end },
                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = vim.api.nvim_create_augroup('EslintAutofix', { clear = true }),
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end,
                settings = {
                    eslint = {
                        validate = 'on',
                        packageManager = 'yarn',
                        autoFixOnSave = 'true',
                        format = {
                            enable = 'true',
                        }
                    }
                },
                root_dir = util.root_pattern('.eslintrc.json', '.eslintrc.js', '.eslintrc', '.eslintrc', 'project.json'),
            },
            lua_ls = {
                on_init = function(client, bufnr)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
                            return
                        end
                    end
                end,
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        pattern = '*.lua',
                        callback = function()
                            if vim.bo.buftype == '' then
                                vim.lsp.buf.format({ async = false })
                            end
                        end,
                    })
                end,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = vim.split(package.path, ';'),
                        },
                        diagnostics = {
                            globals = {
                                'vim',
                                'use',
                                'describe',
                                'it',
                                'assert',
                                'before_each',
                                'after_each',
                            }
                        },
                        completion = {
                            enable = true,
                            callSnippet = 'Both',
                            keywordSnippet = 'Replace',
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                        telemetry = {
                            enable = false,
                        },
                        format = {
                            enable = true,
                            defaultConfig = {
                                quote_style = 'single',
                                indent_style = 'tab',
                                indent_size = '4',
                            },
                        },
                        lint = {
                            enable = true,
                            command = 'luacheck',
                            args = {
                                '--globals',
                                'vim',
                                '--formatter',
                                'plain',
                                '--codes',
                                '--ranges',
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
                cmd = { 'golangci-lint-langserver' },
                root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
                init_options = {
                    command = { 'golangci-lint', 'run', '--out-format', 'json', '--issues-exit-code=1' },
                },
                filetypes = { 'go', 'gomod' }
            },
            gopls = {
                capabilities = capabilities,
                on_attach = function()
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = vim.api.nvim_create_augroup('goimports', {}),
                        pattern = '*.go',
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
                        noSemanticString = true,
                        matcher = 'fuzzy',
                        gofumpt = true,
                        symbolMatcher = 'fuzzy',
                        vulncheck = 'Imports',
                        hoverKind = 'FullDocumentation',
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
                        directoryFilters = { '-.git', '-node_modules', '-.idea', '-.vscode-test', '-.vscode' },
                        buildFlags = { '-tags', 'integration' },
                    }
                },
                filetypes = {
                    'go',
                    'gomod',
                    'gosum',
                    'gowork',
                    'gotmpl',
                    'gohtmltmpl',
                    'gotexttmpl',
                },
            },
            jsonls = {
                on_attach = on_attach,
                settings = {
                    json = {
                        schemas = {
                            {
                                fileMatch = { 'package.json' },
                                url = 'https://json.schemastore.org/package.json'
                            },
                            {
                                fileMatch = { 'tsconfig*.json' },
                                url = 'https://json.schemastore.org/tsconfig.json'
                            },
                            {
                                fileMatch = { '.eslintrc.json', '.eslintrc' },
                                url = 'https://json.schemastore.org/eslintrc.json'
                            },
                            {
                                fileMatch = { 'prettierrc.json', 'prettier.config.json' },
                                url = 'https://json.schemastore.org/prettierrc.json'
                            }
                        },
                    },
                    validate = {
                        enable = true
                    }
                },
            },
            gitlab_ci_ls = {
                filetypes = { 'yaml.gitlab-ci' },
            },
            yamlls = {
                on_attach = on_attach,
                filetypes = { 'yaml.gitlab-ci', 'yaml', 'yml' },
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
                        customTags = {
                            '!reference sequence',
                        },
                        schemas = {
                            kubernetes = '/*.k8s.yaml',
                            ['http://json.schemastore.org/github-workflow'] = '/.github/workflows/*',
                            ['http://json.schemastore.org/github-action'] = '/.github/action.{yml,yaml}',
                            ['http://json.schemastore.org/drone'] = '/.drone.{yml,yaml}',
                            ['http://json.schemastore.org/chart'] = '/Chart.{yml,yaml}',
                            ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = {
                                '.gitlab-ci.yml',
                                '.gitlab-ci.yaml',
                                'gitlab/*.yml',
                                'ci/**/*.yml',
                            },
                        },
                        validate = true,
                        completion = true,
                        hover = true,
                        keyOrdering = false,
                    }
                }
            },
            bashls = {
                name = 'bash-language-server',
                cmd = { 'bash-language-server', 'start' },
                filetypes = { 'sh' }
            },
            angularls = {
                cmd = { 'yarn', 'dlx', '@angular/language-server', '--stdio' },
                on_new_config = function(new_config, _)
                    new_config.cmd = {
                        'yarn', 'dlx', '@angular/language-server',
                        '--stdio',
                        '--tsProbeLocations', vim.fn.getcwd(),
                        '--ngProbeLocations', vim.fn.getcwd()
                    }
                end,
                root_dir = function(fname)
                    local git_root = vim.fs.find('.git', { path = fname, upward = true })[1]
                    return util.root_pattern('angular.json', 'project.json', 'tsconfig.json', 'package.json', 'nx.json',
                            'migrations.json')(fname) or
                        (git_root and vim.fs.dirname(git_root))
                end,
                filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' },
                settings = {
                    angular = {
                        enableStrictMode = true,
                    },
                },
            },
            sqlls = {},
            marksman = {},
        }

        for server_name, config in pairs(servers) do
            config.capabilities = capabilities
            lspconfig[server_name].setup(config)
        end
    end,
}
