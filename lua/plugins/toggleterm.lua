return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        local toggleterm = require("toggleterm")

        toggleterm.setup({
            size = 20,
            open_mapping = [[<leader>ç]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = false,
            shell = vim.o.shell,
            highlights = {
                NormalFloat = {
                    guibg = "#2E3440",
                },
                FloatBorder = {
                    guifg = "#88C0D0",
                },
            },
            float_opts = {
                border = "curved",
                winblend = 2,
                width = 150,
                height = 20,
            },
        })

        -- Function to clear the terminal
        vim.keymap.set('t', '<C-l>', function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>i clear<C-M>", true, false, true), "n",
                false)
        end, { silent = true, noremap = true }, { desc = "Clear the toggleterm terminal" })

        function _G.set_terminal_keymaps()
            local opts = { silent = true, noremap = true }
            -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
            -- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-w>h', [[<C-\><C-n><C-W>h]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-w>j', [[<C-\><C-n><C-W>j]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-w>k', [[<C-\><C-n><C-W>k]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-w>l', [[<C-\><C-n><C-W>l]], opts)
        end

        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
}
