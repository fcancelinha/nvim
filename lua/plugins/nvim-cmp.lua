return {
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    lazy = false,
    dependencies = {
        "Jezda1337/nvim-html-css",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-git",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "onsails/lspkind.nvim",
        "saadparwaiz1/cmp_luasnip",
        'lukas-reineke/cmp-under-comparator',
    },
    config = function()
        local cmp = require('cmp')
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')

        cmp.setup({
            preselect = 'item',
            performance = {
                trigger_debounce_time = 200,
                throttle = 200,
                fetching_timeout = 100,
            },
            completion = {
                completeopt = 'menu,menuone,noinsert,preview'
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, item)
                    local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "  (" .. (strings[2] or "") .. ")"

                    return item
                end
            },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                side_padding = 0,
                col_offset = 0,
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    border = "single",
                    scrollbar = true,
                }),
                documentation = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    border = "single",
                    scrollbar = true,
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ["<C-p>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "v", "i", "c" }),
                ["<C-n>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "v", "i", "c" }),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ['<Tab>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            -- sorting = {
            -- 	-- priority_weight = 2,
            -- 	-- comparators = {
            -- 	-- 	-- compare.exact,
            -- 	-- 	-- compare.score,
            -- 	-- 	-- compare.locality,
            -- 	-- 	-- compare.kind,
            -- 	-- 	-- compare.length,
            -- 	-- 	-- compare.sort_text,
            -- 	-- 	-- compare.order,
            -- 	-- 	-- compare.offset,
            -- 	-- 	-- compare.deprecated,
            -- 	-- }
            -- },
            sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'luasnip' },
                    { name = 'treesitter' },
                    { name = 'tags' },
                    { name = "vim-dadbod-completion" },
                },
                {
                    source = "buffer"
                }
            )
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'buffer' },
                { name = 'git' },
            })
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            formatting = {
                fields = { 'abbr' },
            },
            mapping = cmp.mapping.preset.cmdline({
                ["<C-y>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
            }),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            completion = {
                completeopt = 'noselect'
            }
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            formatting = {
                fields = { 'abbr' },
            },
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            },
        })

        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
    end,
}
