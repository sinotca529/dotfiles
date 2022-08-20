return {
    use_arg_list = {
        {
            'kyazdani42/nvim-tree.lua',
            requires = {
                'kyazdani42/nvim-web-devicons',
            },
        },
    },
    init = function()
        require('nvim-tree').setup({
            view= {
                adaptive_size = true,
            },
            renderer = {
                group_empty = true,
            },
        })
    end,
}

-- return {
--     use_arg_list = {
--         {'sidebar-nvim/sidebar.nvim'},
--     },
--     init = function()
--         require('sidebar-nvim').setup({
--             open = true,
--         })
--     end
-- }

