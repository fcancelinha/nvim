return {
    src = 'zbirenbaum/copilot.lua',
    deps = { 'copilotlsp-nvim/copilot-lsp' },
    config = function()
        require('copilot').setup({
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
            },
            disable_limit_reached_message = false,
        })
    end,
}
