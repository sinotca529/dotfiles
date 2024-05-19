return {
    "nvimtools/none-ls.nvim",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.textlint.with({
                    filetypes = { "tex" },
                }),
            },
        })
    end
}
