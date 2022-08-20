return {
    use_arg_list = {
        {'lukas-reineke/indent-blankline.nvim'}
    },
    init = function()
        require('indent_blankline').setup({})
    end
}
