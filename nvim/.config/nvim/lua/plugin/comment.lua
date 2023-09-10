return {
    'numToStr/Comment.nvim',
    keys = {
        { '<leader>cl', mode = 'n' },
        { '<leader>cl', mode = 'v' },
    },
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
