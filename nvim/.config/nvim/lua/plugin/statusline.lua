local use_arg_list = {
    {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true },
    }
}

local init = function()
    require('lualine').setup({})
end

return {
    use_arg_list = use_arg_list,
    init = init,
}

