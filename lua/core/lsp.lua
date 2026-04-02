-- LSP Configuration using Neovim's native APIs (0.11+)
-- This module configures Language Server Protocol clients using Neovim's built-in LSP support

---@type lsp.ClientCapabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--- Load server configurations from the lsp/ directory
---@return table<string, table> server_configs Map of server names to their configurations
local function load_server_configs()
    local servers_path = vim.fn.stdpath('config') .. '/lsp/'
    local server_files = vim.fn.globpath(servers_path, '*.lua', false, true)
    local server_configs = {}

    for _, file_path in ipairs(server_files) do
        local filename = vim.fn.fnamemodify(file_path, ':t:r')
        local ok, config = pcall(dofile, file_path)
        if ok and type(config) == 'table' then
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
        config.capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {})
        vim.lsp.config(server_name, config)
    end

    -- Servers without custom configurations (basic setup)
    local manual_servers = {
        'bashls',
        'dockerls',
        'eslint',
    }

    for _, server_name in ipairs(manual_servers) do
        if not server_configs[server_name] then
            vim.lsp.config(server_name, {
                capabilities = capabilities,
            })
        end
    end

    -- Enable all servers (Neovim 0.11+ handles this automatically with lsp/ directory)
    -- vim.lsp.enable() is called automatically for files in lsp/ directory
    local all_servers = vim.list_extend(vim.tbl_keys(server_configs), manual_servers)
    vim.lsp.enable(all_servers)
end

-- Initialize LSP configuration
setup_servers()
