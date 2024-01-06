return {
	"iamcco/markdown-preview.nvim",
	iamcco = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function() vim.fn["mkdp#util#install"]() end,
}
