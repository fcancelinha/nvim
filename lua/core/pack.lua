-- Plugin installation via Neovim's built-in manager (:h vim.pack).
local function gh(repo)
    return 'https://github.com/' .. repo
end

-- Build hooks. Must be registered before the first vim.pack call so they also
-- fire for the initial install from the lockfile.
vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('PackBuild', { clear = true }),
    callback = function(ev)
        local changed = ev.data.kind == 'install' or ev.data.kind == 'update'
        if not changed then return end

        if ev.data.spec.name == 'neotest-golang' then
            vim.system({ 'go', 'install', 'gotest.tools/gotestsum@latest' })
        end
    end,
})

vim.pack.add({
    -- Shared libraries
    gh('nvim-lua/plenary.nvim'),
    gh('MunifTanjim/nui.nvim'),
    gh('nvim-neotest/nvim-nio'),

    -- UI
    gh('echasnovski/mini.icons'),
    gh('folke/snacks.nvim'),
    gh('folke/persistence.nvim'),
    gh('Bekaboo/dropbar.nvim'),
    gh('brenoprata10/nvim-highlight-colors'),
    gh('nvim-neo-tree/neo-tree.nvim'),
    gh('nvim-lualine/lualine.nvim'),
    gh('s1n7ax/nvim-window-picker'),

    { src = gh('saghen/blink.cmp'),             version = vim.version.range('1') },
    gh('rafamadriz/friendly-snippets'),

    -- LSP tooling
    gh('mason-org/mason.nvim'),
    gh('folke/lazydev.nvim'),

    -- AI
    { src = gh('olimorris/codecompanion.nvim'), version = vim.version.range('20') },
    gh('zbirenbaum/copilot.lua'),
    gh('copilotlsp-nvim/copilot-lsp'), -- copilot.lua dependency

    -- Tree-sitter
    gh('nvim-treesitter/nvim-treesitter'),
    gh('Wansmer/treesj'),

    -- Editing
    gh('windwp/nvim-autopairs'),
    gh('kylechui/nvim-surround'),
    gh('echasnovski/mini.align'),
    gh('MagicDuck/grug-far.nvim'),
    gh('serhez/bento.nvim'),
    gh('MeanderingProgrammer/render-markdown.nvim'),
    gh('stevearc/conform.nvim'),

    -- Git & diagnostics
    gh('lewis6991/gitsigns.nvim'),
    gh('folke/todo-comments.nvim'),
    gh('esmuellert/codediff.nvim'),
    gh('folke/trouble.nvim'),

    -- Test & debug
    gh('nvim-neotest/neotest'),
    gh('fredrikaverpil/neotest-golang'),
    gh('nvim-neotest/neotest-python'),
    gh('mfussenegger/nvim-dap'),
    gh('rcarriga/nvim-dap-ui'),
    gh('theHamsta/nvim-dap-virtual-text'),
    gh('leoluz/nvim-dap-go'),
    gh('mfussenegger/nvim-dap-python'),
    gh('jay-babu/mason-nvim-dap.nvim'),
})
