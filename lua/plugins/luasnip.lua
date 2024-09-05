return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    version = "2.*",
    build = vim.fn.has "win32" ~= 0 and "make install_jsregexp" or nil,
    keys = {
        { "<Tab>",   function() require('luasnip').expand() end,                                                        { "i" }, desc = "expand snippet" },
        { "<Tab>",   function() require('luasnip').jump(1) end,                                                         { "i", "s" }, desc = "jump to next parameter" },
        { "<S-Tab>", function() require('luasnip').jump(-1) end,                                                        { "i", "s" }, desc = "jump to previous parameter" },
        { "<C-E>",   function() if require('luasnip').choice_active() then require('luasnip').change_choice(1) end end, { "i", "s" }, desc = "toggle luasnip" },
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}
