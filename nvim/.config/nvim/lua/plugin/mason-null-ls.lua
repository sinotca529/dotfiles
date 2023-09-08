return {
    'jay-babu/mason-null-ls.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        "williamboman/mason.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
        require('mason-null-ls').setup({
            automatic_setup = true,
            handlers = {},
        })
    end
}
