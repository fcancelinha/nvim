return {
    src = 'avante-corp/avante.nvim',
    build = 'make',
    deps = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'ColinKennedy/mega.logging',
        'ColinKennedy/mega.cmdparse',
    },
    config = function()
        require('avante').setup({
            provider = 'copilot',
            debug = true, -- keep while testing
            log_level = 'debug',
            behaviour = {
                auto_suggestions = false,
            },
        })
    end,
}
