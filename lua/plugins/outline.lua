return {
    "hedyhli/outline.nvim",
    keys = {
        { "<leader>o", ":Outline<CR>", { desc = "Toggle Outline" } },
    },
    config = function()
        -- Example mapping to toggle outline

        require("outline").setup {}
    end,
}
