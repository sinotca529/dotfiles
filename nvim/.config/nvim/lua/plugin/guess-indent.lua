return {
    'NMAC427/guess-indent.nvim',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = function()
        require('guess-indent').setup({
            override_editorconfig = true,
        })
    end
}
