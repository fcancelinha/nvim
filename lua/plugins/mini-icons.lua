return {
    src = 'echasnovski/mini.icons',
    priority = 100, -- must mock devicons before lualine, neo-tree and snacks set up
    config = function()
        require('mini.icons').setup()

        -- Anything still asking for nvim-web-devicons gets mini.icons instead.
        require('mini.icons').mock_nvim_web_devicons()
    end,
}
