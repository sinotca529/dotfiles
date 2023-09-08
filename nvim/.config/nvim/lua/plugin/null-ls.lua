return {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        require('null-ls').setup()
    end
}
