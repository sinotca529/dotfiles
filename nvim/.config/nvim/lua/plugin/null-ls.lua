return {
    "nvimtools/none-ls.nvim",
    lazy = true,
    config = function()
        require('null-ls').setup()
    end
}
