return {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    event = 'InsertEnter',
    config = function()
        require('null-ls').setup()
    end
}
