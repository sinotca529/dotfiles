return {
    use_arg_list = {
        { 'sinotca529/adjust-indent.nvim'},
    },
    init = function()
        require('adjust-indent').setup()
    end,
}

