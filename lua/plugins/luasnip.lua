return {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node

        require("luasnip").add_snippets("go", {
            s("main", {
                -- Package declaration
                t({ "package main", "", "import (", "    \"" }),
                -- Import placeholder, default to "fmt"
                t("fmt"), t({ "\"", ")", "", "func main() {", "    " }),
                -- Main function body placeholder
                t('fmt.Println("Hello, World!")'),
                -- Close the main function
                t({ "", "}" })
            })
        })
    end
}
