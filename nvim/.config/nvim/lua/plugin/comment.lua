return {
    'numToStr/Comment.nvim',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    config = function()
        require('Comment').setup({
            line_mapping = '<leader>cc',
            toggler = {
                line = '<leader>cl',
            },
            opleader = {
                line = '<leader>cl',
            },
        })
    end
}
