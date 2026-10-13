-- Auto-start Tree-sitter highlighting for all files
vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function()
        pcall(vim.treesitter.start) -- "pcall" prevents errors if no parser exists
    end,
})

-- Python buffer-local tweaks. Globally 'smartindent'/'cindent' are on for C-like
-- languages, and smartindent is what yanks a leading '#' to column 0 on insert.
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('python_indent', { clear = true }),
    pattern = 'python',
    callback = function(event)
        vim.bo[event.buf].smartindent = false
        vim.bo[event.buf].cindent = false
        vim.bo[event.buf].textwidth = 88 -- matches ruff lineLength in lsp/ruff.lua
        vim.wo.colorcolumn = '89'
    end,
})

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
    callback = function()
        vim.hl.on_yank({ higroup = 'Yank', timeout = 200 })
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
        -- Default keymaps in 0.11:
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
    end,
})
