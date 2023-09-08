return {
    'numToStr/Comment.nvim',
    lazy = true,
    keys = { '<leader>cl' },
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
