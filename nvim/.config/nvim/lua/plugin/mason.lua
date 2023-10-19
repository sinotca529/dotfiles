return {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = function()
        require('mason').setup({
            ui = {
                border = 'single'
            }
        })
    end,
}
