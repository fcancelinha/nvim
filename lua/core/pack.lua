-- Plugin installation via Neovim's built-in manager (:h vim.pack).
local function gh(repo)
    return 'https://github.com/' .. repo
end

--- Avante critical build step for pack
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == 'avante.nvim'
            and (kind == 'install' or kind == 'update') then
            vim.system({ 'make' }, {
                cwd = ev.data.path,
            }):wait()
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

    { src = gh('saghen/blink.cmp'), version = vim.version.range('1') },
    gh('rafamadriz/friendly-snippets'),

    -- LSP tooling
    gh('mason-org/mason.nvim'),
    gh('folke/lazydev.nvim'),

    -- AI
    gh('zbirenbaum/copilot.lua'),
    gh('copilotlsp-nvim/copilot-lsp'),
    gh('avante-corp/avante.nvim'),

    -- Common Deps
    gh('nvim-lua/plenary.nvim'),
    gh('MunifTanjim/nui.nvim'),
    gh('ColinKennedy/mega.logging'),
    gh('ColinKennedy/mega.cmdparse'),

    -- Optional deps
    gh('MeanderingProgrammer/render-markdown.nvim'),
    gh('hrsh7th/nvim-cmp'),
    gh('nvim-tree/nvim-web-devicons'), -- or 'echasnovski/mini.icons'
    gh('HakonHarnes/img-clip.nvim'),
    gh('folke/snacks.nvim'),           -- for modern input UI

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
    gh('mfussenegger/nvim-dap'),
    gh('rcarriga/nvim-dap-ui'),
    gh('theHamsta/nvim-dap-virtual-text'),
    gh('leoluz/nvim-dap-go'),
    gh('jay-babu/mason-nvim-dap.nvim'),
})
