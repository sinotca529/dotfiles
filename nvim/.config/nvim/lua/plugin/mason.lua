return {
    'williamboman/mason.nvim',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = function()
        require('mason').setup({})
    end,
}
