return {
    'yetone/avante.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'folke/snacks.nvim',      -- for input provider snacks
        'zbirenbaum/copilot.lua', -- for providers='copilot'
        {
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { 'markdown', 'Avante' },
            },
            ft = { 'markdown', 'Avante' },
        },
    },
    build = vim.fn.has('win32') ~= 0
        and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
        or 'make',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        instructions_file = 'avante.md',
        provider = 'claude',
        claude = {
            endpoint = 'https://api.anthropic.com',
            model = 'claude-3-5-sonnet-20241022',
            temperature = 0,
            max_tokens = 4096,
        },
        input = {
            provider = 'snacks',
            provider_opts = {
                title = 'Avante input',
                icon = ' ',
            },
        },
        selector = {
            provider = 'snacks',
        }
    },
}
