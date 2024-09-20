return {
    {
        "iamcco/markdown-preview.nvim",
        name = 'markdown-preview',
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    -- {
    --     'MeanderingProgrammer/render-markdown.nvim',
    --     opts = {
    --         file_types = { "markdown", "Avante" },
    --     },
    --     ft = { "markdown", "Avante" },
    -- },
}
