-- local function sidebar(use)
--     use({'sidebar-nvim/sidebar.nvim'})
--     require('sidebar-nvim').setup({
--        open = true,
--     })
-- end

local function nvim_tree(use)
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
    }
    require('nvim-tree').setup({
        view= {
            adaptive_size = true,
        },
        renderer = {
            group_empty = true,
        },
    })
end

local function telescope(use)
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    vim.keymap.set('n', 'ff', '<cmd>Telescope find_files<CR>')
end

local function toggle_term(use)
    use {
        'akinsho/toggleterm.nvim',
        tag = 'v2.*',
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<C-@>]],
                insert_mappings = true,
                close_on_exit = true,
                direction = 'float',
                -- float_opts = {
                --     winblend = 10,
                -- },
            })
        end
    }
end

return function(use)
    nvim_tree(use)
    telescope(use)
    toggle_term(use)
end
