return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").setup {
			override_by_extension = {
				["robocop"] = {
					icon = "",
					color = "#633974",
					name = "Robocorp"
				},
				["mod"] = {
					icon = "",
					color = "#6d8086",
					name = "Go.Mod"
				},
				["sum"] = {
					icon = "",
					color = "#6d8086",
					name = "Go.Sum"
				},
				["cov"] = {
					icon = "",
					color = "#E67E22",
					name = "Coverage"
				}
			},
		}
	end,
}
