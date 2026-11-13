return {
    src = 'MeanderingProgrammer/render-markdown.nvim',
    config = function()
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        require('render-markdown').setup({
            file_types = { 'markdown', 'codecompanion', 'codecompanion_chat_input' },
        })
    end,
}
