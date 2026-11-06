-- The copilot adapter reads its OAuth token from ~/.config/github-copilot,
-- falling back to the sqlite auth.db that copilot-language-server now writes.
-- That fallback shells out to sqlite3, so it must be on PATH.
require('codecompanion').setup({
    interactions = {
        chat = { adapter = 'copilot' },
        inline = { adapter = 'copilot' },
    },
})

local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
end

map({ 'n', 'x' }, '<Leader>aa', '<Cmd>CodeCompanionActions<CR>', 'AI action palette')
map({ 'n', 'x' }, '<Leader>ac', '<Cmd>CodeCompanionChat Toggle<CR>', 'AI chat toggle')
map({ 'n', 'x' }, '<Leader>ai', ':CodeCompanion ', 'AI inline prompt')
map('x', '<Leader>ad', '<Cmd>CodeCompanionChat Add<CR>', 'AI add selection to chat')

vim.cmd.cnoreabbrev('cc CodeCompanion')
