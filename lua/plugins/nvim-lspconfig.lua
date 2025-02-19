return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')

    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require('mason').setup({
      ui = {
        check_outdated_packages_on_open = true,
        border = 'rounded',
        width = 85,
        height = 0.9,
      },
    })

    require('lspconfig.ui.windows').default_options.border = 'rounded'
    local signs = { Error = '✸ ', Warn = ' ', Hint = ' ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    vim.api.nvim_create_autocmd('TextYankPost', {
      group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
      callback = function()
        vim.highlight.on_yank({ higroup = 'Yank', timeout = 200 })
      end,
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function(args)
        require('conform').format({ bufnr = args.buf })
      end,
    })

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(event)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local lsp_opts = { buffer = event.buf, silent = true, noremap = true }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, lsp_opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, lsp_opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, lsp_opts)
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, lsp_opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, lsp_opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, lsp_opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, lsp_opts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, lsp_opts)
      end,
    })


    local servers_path = vim.fn.stdpath('config') .. '/lua/plugins/servers'
    local server_files = vim.fn.globpath(servers_path, '*.lua', false, true)

    for _, file in ipairs(server_files) do
      local server_name = vim.fn.fnamemodify(file, ':t:r')

      local success, config = pcall(require, 'plugins.servers.' .. server_name)
      if success then
        config.capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {})
        lspconfig[server_name].setup(config)
      else
        vim.notify('Error loading configuration for', server_name, ':', config)
      end
    end
  end,
}
