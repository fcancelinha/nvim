local util = require('lspconfig.util')

return {
  cmd = { 'yarn', 'eslint', '--stdin', '--stdin-filename', function()
    return vim.api.nvim_buf_get_name(0)
  end },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('EslintAutofix', { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
  settings = {
    eslint = {
      validate = 'on',
      packageManager = 'yarn',
      autoFixOnSave = 'true',
      format = {
        enable = 'true',
      }
    }
  },
  root_dir = util.root_pattern('.eslintrc.json', '.eslintrc.js', '.eslintrc', '.eslintrc', 'project.json'),

}
