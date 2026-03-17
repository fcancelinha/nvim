-- LSP Configuration using Neovim's native APIs
-- This module configures Language Server Protocol clients using Neovim's built-in LSP support

---@type lsp.ClientCapabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--- Shared on_attach function for all LSP clients
---@param client lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    -- Enable format on save if the server supports document formatting
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
            end,
            desc = 'Format buffer on save',
        })
    end
end

--- Load server configurations from the lsp/ directory
---@return table<string, table> server_configs Map of server names to their configurations
local function load_server_configs()
    local servers_path = vim.fn.stdpath('config') .. '/lua/lsp/'
    local server_files = vim.fn.globpath(servers_path, '*.lua', false, true)
    local server_configs = {}

    for _, file_path in ipairs(server_files) do
        local filename = vim.fn.fnamemodify(file_path, ':t:r')
        local ok, config = pcall(require, 'lsp.' .. filename)
        if ok then
            server_configs[filename] = config
        else
            vim.notify(string.format('Failed to load LSP config for %s: %s', filename, config), vim.log.levels.WARN)
        end
    end

    return server_configs
end

--- Configure LSP servers using Neovim's native APIs
local function setup_servers()
    local server_configs = load_server_configs()

    -- Servers with custom configurations
    for server_name, config in pairs(server_configs) do
        -- Merge capabilities and set on_attach
        config.capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {})
        config.on_attach = on_attach
        vim.lsp.config(server_name, config)
    end

    -- Servers without custom configurations
    local manual_servers = {
        'bashls',
        'dockerls',
        'golangci_lint_ls',
        'eslint',
    }

    for _, server_name in ipairs(manual_servers) do
        if not server_configs[server_name] then
            vim.lsp.config(server_name, {
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end
    end

    -- Collect all server names and enable them after a delay to allow Mason to install
    local all_servers = vim.list_extend(vim.tbl_keys(server_configs), manual_servers)
    vim.defer_fn(function()
        vim.lsp.enable(all_servers)
    end, 3000) -- Wait 3 seconds for Mason to install servers
end

-- Initialize LSP configuration
setup_servers()
