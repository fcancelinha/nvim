local lspconfig = require('lspconfig')

return {
  cmd = { 'golangci-lint-langserver' },
  root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
  init_options = {
    command = { 'golangci-lint', 'run', '--out-format', 'json', '--issues-exit-code=1' },
  },
  filetypes = { 'go', 'gomod' }

}
