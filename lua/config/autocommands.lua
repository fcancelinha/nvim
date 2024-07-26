vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'Yank', timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.lua,*.json,*.yaml,*.yml,*.css,*.scss,*.html,*.xml,*.sh",
    command = "lua vim.lsp.buf.format()",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = ".gitlab*",
    callback = function()
        vim.bo.filetype = "yaml.gitlab"
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.robot",
    callback = function()
        vim.bo.filetype = "robot"
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("goimports", {}),
    pattern = "*.go",
    callback = function()
        require('go.format').goimports()
    end,
})
