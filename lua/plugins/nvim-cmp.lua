return {
    'hrsh7th/nvim-cmp',
    lazy = false,
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',
        'lukas-reineke/cmp-under-comparator',
        'onsails/lspkind.nvim',
        'petertriho/cmp-git',
    },
    config = function()
        local cmp = require('cmp')
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')

        ---@diagnostic disable-next-line: redundant-parameter
        cmp.setup({
            enabled = function()
                local context = require('cmp.config.context')
                local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })
                -- keep command mode completion enabled when cursor is in a comment
                if buftype == 'prompt' then
                    return false
                end

                if buftype == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture('comment')
                        and not context.in_syntax_group('Comment')
                end
            end,
            preselect = cmp.PreselectMode.Item,
            performance = {
                trigger_debounce_time = 200,
                throttle = 200,
                fetching_timeout = 100,
            },
            completion = {
                completeopt = 'menu,menuone,noinsert,preview'
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    local kind = require('lspkind').cmp_format({ mode = 'symbol', maxwidth = 80 })(entry, vim_item)
                    local strings = vim.split(kind.kind, ' %s ', { trimempty = false })
                    kind.kind = ' ' .. (strings[1] or '') .. ' '
                    -- kind.menu = '  (' .. (strings[2] or '') .. ')'

                    local highlights_info = require('colorful-menu').cmp_highlights(entry)
                    -- highlight_info is nil means we are missing the ts parser, it's
                    -- better to fallback to use default `vim_item.abbr`. What this plugin
                    -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                    if highlights_info ~= nil then
                        vim_item.abbr_hl_group = highlights_info.highlights
                        vim_item.abbr = highlights_info.text
                    end

                    return vim_item
                end
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = {
                    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
                    border = 'rounded',
                    scrollbar = true,
                    side_padding = 1,
                    col_offset = 1,
                },
                documentation = {
                    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
                    border = 'rounded',
                    scrollbar = true,
                    side_padding = 1,
                    col_offset = 1,
                },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'v', 'i', 'c' }),
                ['<C-n>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'v', 'i', 'c' }),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if vim.snippet.active({ direction = 1 }) then
                        vim.snippet.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if vim.snippet.active({ direction = -1 }) then
                        vim.snippet.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sorting = {
                priority_weight = 1,
                comparators = {
                    cmp.config.compare.score,
                    cmp.config.compare.exact,
                    cmp.config.compare.offset,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.order,
                    cmp.config.compare.locality,
                    cmp.config.compare.length,
                    cmp.config.compare.deprecated,
                }
            },
            sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'treesitter' },
                    { name = 'tags' },
                    { name = 'vim-dadbod-completion' },
                    { name = 'render-markdown' },
                },
                {
                    name = 'buffer'
                }
            )
        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' },
            }, {
                { name = 'buffer' },
            })
        })

        require('cmp_git').setup()

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            formatting = {
                fields = { 'abbr' },
            },
            mapping = cmp.mapping.preset.cmdline({
                ['<C-y>'] = cmp.mapping.confirm({
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
