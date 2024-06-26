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
        local compare = require('cmp.config.compare')
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')

        local kind_icons = {
            Text = ' ',
            Method = ' ',
            Function = '󰊕 ',
            Constructor = ' ',
            Field = ' ',
            Variable = ' ',
            Class = ' ',
            Interface = ' ',
            Module = ' ',
            Property = ' ',
            Unit = ' ',
            Value = ' ',
            Enum = ' ',
            Keyword = '󰌋 ',
            Snippet = ' ',
            Color = ' ',
            File = '󰈙 ',
            Reference = ' ',
            Folder = ' ',
            EnumMember = ' ',
            Constant = '󰏿 ',
            Struct = '',
            Event = ' ',
            Operator = ' ',
            TypeParameter = ' ',
        }

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
                    -- Kind icons
                    item.kind = string.format('%s ', kind_icons[item.kind]) -- This concatonates the icons with the name of the item kinde
                    item.abbr = string.sub(item.abbr, 1, 25)

                    item.menu = ({
                        buffer = '',
                        luasnip = '',
                        nvim_lsp = '',
                        nvim_lua = '',
                        path = '',
                        rg = '',
                    })[entry.source.name]

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
            sorting = {
                priority_weight = 2,
                comparators = {
                    compare.exact,
                    compare.score,
                    compare.locality,
                    compare.kind,
                    compare.length,
                    compare.sort_text,
                    compare.order,
                    compare.offset,
                    compare.deprecated,
                }
            },
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'nvim_lua' },
                { name = 'treesitter' },
                { name = 'tags' },
                { name = 'cmdline' },
                { name = "vim-dadbod-completion" },
            })
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
