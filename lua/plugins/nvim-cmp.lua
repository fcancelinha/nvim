return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
        "Jezda1337/nvim-html-css",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind.nvim",
        'lukas-reineke/cmp-under-comparator',
    },
    config = function()
        local cmp = require('cmp')
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')

        cmp.setup({
            enabled = function()
                local context = require("cmp.config.context")
                local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                -- keep command mode completion enabled when cursor is in a comment
                if buftype == 'prompt' then
                    return false
                end

                if buftype == 'c' then
                else
                    return true
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
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
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            window = {
                side_padding = 0,
                col_offset = 0,
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    border = "rounded",
                    scrollbar = true,
                }),
                documentation = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    border = "rounded",
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
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if vim.snippet.active() then
                        vim.snippet.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if vim.snippet.active() then
                        vim.snippet.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            -- sorting = {
            -- priority_weight = 1,
            -- comparators = {
            --     cmp.config.compare.score,
            --     cmp.config.compare.exact,
            --     cmp.config.compare.offset,
            --     cmp.config.compare.kind,
            --     cmp.config.compare.sort_text,
            --     cmp.config.compare.order,
            --     cmp.config.compare.locality,
            --     cmp.config.compare.length,
            --     cmp.config.compare.deprecated,
            -- }
            -- },
            sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'treesitter' },
                    { name = 'tags' },
                    { name = "vim-dadbod-completion" },
                },
                {
                    source = "buffer"
                }
            )
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
