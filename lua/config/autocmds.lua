-- Auto-start Tree-sitter highlighting for all files
vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function()
        pcall(vim.treesitter.start) -- "pcall" prevents errors if no parser exists
    end,
})

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
    callback = function()
        vim.hl.on_yank({ higroup = 'Yank', timeout = 200 })
    end,
})

-- LspAttach autocommand for LSP-specific configuration
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local bufnr = event.buf

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Custom keymaps that complement Neovim 0.11 defaults
        -- grn (rename),
        -- gra (code_action),
        -- grr (references),
        -- gri (implementation),
        -- gO (document_symbol),
        -- K (hover),
        -- [d/]d (diagnostics)

        local opts = function(desc)
            return { buffer = bufnr, silent = true, noremap = true, desc = 'LSP: ' .. desc }
        end

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('Go to declaration'))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts('Go to definition'))
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts('Go to type definition'))
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts('Signature help'))
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts('Open diagnostic float'))

        -- Format on save for supported clients
        -- Format on save lives in conform.nvim, which falls back to the LSP
        -- formatter for any filetype without a dedicated formatter configured.

        if client and client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        -- Highlight other occurrences of the symbol under the cursor, after
        -- 'updatetime' (100ms) and in normal mode only. Replaces
        -- vim-illuminate. Guarded because several clients attach per buffer.
        if client and client:supports_method('textDocument/documentHighlight')
            and not vim.b[bufnr].lsp_highlight_attached then
            vim.b[bufnr].lsp_highlight_attached = true

            local group = vim.api.nvim_create_augroup('UserLspHighlight', { clear = false })

            vim.api.nvim_create_autocmd('CursorHold', {
                group = group,
                buffer = bufnr,
                callback = function() vim.lsp.buf.document_highlight() end,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter' }, {
                group = group,
                buffer = bufnr,
                callback = function() vim.lsp.buf.clear_references() end,
            })
        end
    end,
})
