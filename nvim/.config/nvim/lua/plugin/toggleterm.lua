return {
    use_arg_list = {
        {
            'akinsho/toggleterm.nvim',
            tag = 'v2.*',
            config = function()
                require("toggleterm").setup({
                    open_mapping = [[<C-@>]],
                    insert_mappings = true,
                    close_on_exit = true,
                    direction = 'float',
                    float_opts = {
                        winblend = 10,
                    },
                })
            end
        }
    },
    init = function()
    end
}

