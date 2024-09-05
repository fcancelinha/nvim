return {
    "iamcco/markdown-preview.nvim",
    name = 'markdown-preview',
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
}
