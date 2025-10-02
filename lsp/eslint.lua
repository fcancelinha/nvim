return {
    cmd = {
        'vscode-eslint-language-server',
        '--stdio',
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'vue',
        'svelte',
        'astro',
        'htmlangular',
    },
    root_dir = require('lspconfig').util.root_pattern(
        '.eslintrc.js',
        '.eslintrc.json',
        '.eslintrc',
        'eslint.config.js',
        'package.json',
        'yarn.lock' -- Add this for Yarn projects
    ),
    settings = {
        packageManager = 'yarn', -- or 'yarn', 'pnpm', 'npm'
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = 'separateLine'
            },
            showDocumentation = {
                enable = true
            }
        },
        codeActionOnSave = {
            enable = true,
            mode = 'all'
        },
        experimental = {
            useFlatConfig = true
        },
        format = true,
        nodePath = '',
        onIgnoredFiles = 'off',
        problems = {
            shortenToSingleLine = false
        },
        quiet = false,
        rulesCustomizations = {},
        run = 'onType',
        useESLintClass = false,
        validate = 'on',
        workingDirectory = {
            -- mode = 'auto'
            mode = 'location'
        },
        options = {
            resolvePluginsRelativeTo = nil -- auto-detect
        }
    }
}
