return {
    'mfussenegger/nvim-lint',
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            bash = { 'shellcheck' },
            git = { 'gitlint' },
            go = { 'revive' },
            json = { 'jsonlint' },
            makefile = { 'checkmake' },
            markdown = { 'markdownlint' },
            yaml = { 'yamllint' },
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("lint", { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
