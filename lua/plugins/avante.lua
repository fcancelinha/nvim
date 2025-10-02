return {
    'yetone/avante.nvim',
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ?? must add this setting! ! !
    build = vim.fn.has('win32') ~= 0
        and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
        or 'make',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        -- add any opts here
        -- this file can contain specific instructions for your project
        instructions_file = 'avante.md',
        -- for example
        provider = 'copilot',
    },
    dependencies = {
        'MunifTanjim/nui.nvim',
        --- The below dependencies are optional,
        'stevearc/dressing.nvim', -- for input provider dressing
        'folke/snacks.nvim',      -- for input provider snacks
        'zbirenbaum/copilot.lua', -- for providers='copilot'
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { 'markdown', 'Avante' },
            },
            ft = { 'markdown', 'Avante' },
        },
    },
}
