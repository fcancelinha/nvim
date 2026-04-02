vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'Yank', timeout = 200 })
    end,
})

-- LspAttach autocommand for LSP-specific configuration
-- Note: Neovim 0.11+ provides default keymaps (grn=rename, gra=code_action, grr=references, etc.)
-- We only add custom mappings and features here
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local bufnr = event.buf

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Custom keymaps that complement Neovim 0.11 defaults
        -- Default keymaps in 0.11: grn (rename), gra (code_action), grr (references),
        -- gri (implementation), gO (document_symbol), K (hover), [d/]d (diagnostics)
        local opts = function(desc)
            return { buffer = bufnr, silent = true, noremap = true, desc = 'LSP: ' .. desc }
        end

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('Go to declaration'))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts('Go to definition'))
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts('Go to type definition'))
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts('Signature help'))
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts('Open diagnostic float'))

        -- Enable inlay hints if supported (toggle with <leader>ih)
        if client and client:supports_method('textDocument/inlayHint') then
            vim.keymap.set('n', '<leader>ih', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end, opts('Toggle inlay hints'))
        end

        -- Format on save for supported clients
        if client and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('LspFormat.' .. bufnr, { clear = true }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
                end,
                desc = 'Format buffer on save',
            })
        end
    end,
})
